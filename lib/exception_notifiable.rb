require 'ipaddr'

# Copyright (c) 2010 Robert D. Cotey II
# Copyright (c) 2005 Jamis Buck (git commit e8b603e523c14f145da7b3a1729f5cc06eba2dd1)
#    This file is part of coteyr_pack.
#
#    coteyr_pack is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    coteyr_pack is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with coteyr_pack.  If not, see <http://www.gnu.org/licenses/>.
module ExceptionNotifiable
  def self.included(target)
    target.extend(ClassMethods)
  end

  module ClassMethods
    def consider_local(*args)
      local_addresses.concat(args.flatten.map { |a| IPAddr.new(a) })
    end

    def local_addresses
      addresses = read_inheritable_attribute(:local_addresses)
      unless addresses
        addresses = [IPAddr.new("127.0.0.1")]
        write_inheritable_attribute(:local_addresses, addresses)
      end
      addresses
    end

    def exception_data(deliverer=self)
      if deliverer == self
        read_inheritable_attribute(:exception_data)
      else
        write_inheritable_attribute(:exception_data, deliverer)
      end
    end

    def exceptions_to_treat_as_404
      exceptions = [ActiveRecord::RecordNotFound,
                    ActionController::UnknownController,
                    ActionController::UnknownAction]
      exceptions << ActionController::RoutingError if ActionController.const_defined?(:RoutingError)
      exceptions << Facebooker::Session::SessionExpired if defined?(Facebooker)
      exceptions
    end
  end

  private

    def local_request?
      remote = IPAddr.new(request.remote_ip)
      !self.class.local_addresses.detect { |addr| addr.include?(remote) }.nil?
    end

    def render_404
      respond_to do |type|
        type.html { render :file => "#{RAILS_ROOT}/public/404.html", :status => "404 Not Found" }
        type.all  { render :nothing => true, :status => "404 Not Found" }
      end
    end

    def render_500
      respond_to do |type|
        type.html { render :file => "#{RAILS_ROOT}/public/500.html", :status => "500 Error" }
        type.all  { render :nothing => true, :status => "500 Error" }
      end
    end

    def rescue_action_in_public(exception)
      case exception
        when *self.class.exceptions_to_treat_as_404
          render_404

        else
          render_500

          deliverer = self.class.exception_data
          data = case deliverer
            when nil then {}
            when Symbol then send(deliverer)
            when Proc then deliverer.call(self)
          end

          ExceptionNotifier.deliver_exception_notification(exception, self,
            request, data)
      end
    end
end
