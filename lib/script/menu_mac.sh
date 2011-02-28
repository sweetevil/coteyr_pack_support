#!/bin/bash
# Copyright (c) 2010 by Robert D. Cotey II
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

function menu_prompt {
ans=`CocoaDialog dropdown --title "Rails Script Runner"\
    --items "Which Script" \
	"Commit"\
    "Update"\
    "---------------"\
    "Test All"\
    "Auto Test"\
    "Console"\
    "Start Server"\
    "================="\
    "Create Controller"\
    "Create Migration"\
    "Create Model"\
    "DB Migrate"\
    "****************"\
    "Log View"\
    "Exit" --button1 "ok" | sed 1d`
}

function find_top {
 cd $1
}
function run_stuff {
  cd $RAILS_ROOT
  case "$ans" in
    '1')
      rake coteyr_pack:mac:commit
    ;;
    '2')
      rake coteyr_pack:mac:pull
    ;;
    '4')
      rake coteyr_pack:mac:test_all
    ;;
    '5')
      rake coteyr_pack:mac:auto_test
    ;;
    '6')
      rake coteyr_pack:mac:console
    ;;
    '7')
      rake coteyr_pack:mac:server
    ;;
    '9')
      rake coteyr_pack:mac:controller
    ;;
    '10')
      rake coteyr_pack:mac:migration
    ;;
    '11')
      rake coteyr_pack:mac:model
    ;;
    '12')
      rake coteyr_pack:mac:migrate
    ;;
    '14')
      rake coteyr_pack:mac:log
    ;;
    '15')
      LOOP="false"
    ;;
  esac
}

LOOP="true"
while [ "$LOOP" = "true" ]; do
echo "Running from: $1"
  RAILS_ROOT="$1"
  menu_prompt
  run_stuff
done