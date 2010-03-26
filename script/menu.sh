#!/bin/bash

function menu_prompt {
ans=`kdialog --menu "Which Script" --title "Rails Script Runner"\
    "1" "Commit"\
    "2" "Update"\
    "0" "****************"\
    "3" "Test All"\
    "4" "Auto Test"\
    "5" "Console"\
    "6" "Start Server"\
    "0" "****************"\
    "7" "Create Controller"\
    "8" "Create Migration"\
    "9" "Create Model"\
    "10" "DB Migrate"\
    "0" "****************"\
    "12" "Log View"\
    "11" "Exit"`
}

function find_top {
 cd $1
}
function run_stuff {
  cd $RAILS_ROOT
  case "$ans" in
    '1')
      rake coteyr_pack:linux:commit
    ;;
    '2')
      rake coteyr_pack:linux:pull
    ;;
    '3')
      rake coteyr_pack:linux:test_all
    ;;
    '4')
      rake coteyr_pack:linux:auto_test
    ;;
    '5')
      rake coteyr_pack:linux:console
    ;;
    '6')
      rake coteyr_pack:linux:server
    ;;
    '7')
      rake coteyr_pack:linux:controller
    ;;
    '8')
      rake coteyr_pack:linux:migration
    ;;
    '9')
      rake coteyr_pack:linux:model
    ;;
    '10')
      rake coteyr_pack:linux:migrate
    ;;
    '12')
      rake coteyr_pack:linux:log
    ;;
    '11')
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