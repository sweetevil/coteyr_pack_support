FIRST=`pwd`
cd $1
CHOICE=`kdialog --title "Migration Name" --inputbox "Migration Name"`
script/generate migration $CHOICE
cd $FIRST
kate $1/db/migrate/*_${CHOICE}.rb