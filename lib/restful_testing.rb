module RestfulTesting 

private
	  def restful_actions(id=1, params={})
			id_based_params = params.merge({:id=>id})
			get :show, id_based_params
			assert_response :success
			get :index, params
			assert_response :success
			get :edit, id_based_params
			assert_response :success
			get :create, params
			assert_response :success
			#we can't test success for the minipluations because they may or may not fail but they shold not except
			assert_nothing_raised {
				post :update, id_based_params
				post :create, params
			}
		end


end