FIRST=`pwd`
cd $1
CHOICE=`kdialog --title "Controller Name" --inputbox "Controller Name"`
script/generate controller $CHOICE
cd $FIRST
kate $1/app/controllers/${CHOICE}_controller.rb
kate $1/test/functional/${CHOICE}_controller_test.rb
kate $1/app/helpers/${CHOICE}_helper.rb