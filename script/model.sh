FIRST=`pwd`
cd $1
CHOICE=`kdialog --title "Model Name" --inputbox "Model Name"`
script/generate model $CHOICE
cd $FIRST


kate $1/test/unit/${CHOICE}_test.rb
kate $1/test/fixtures/${CHOICE}s.yml
kate $1/app/models/${CHOICE}.rb
kate $1/db/migrate/*_create_${CHOICE}s.rb