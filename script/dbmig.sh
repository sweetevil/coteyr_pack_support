FIRST=`pwd`
cd $1
cd db/migrate/
OPT=""
for i in *; do
NUM=`echo "$i" | cut -d_ -f1`
NAME=`echo "$i"`
OPT="$OPT $NUM $NAME"
done
CHOICE=`kdialog --title "Choose Migration" --menu "Choose Migration" "ALL" "Current Version" $OPT`
if [ $CHOICE = "ALL" ]; then
konsole --workdir $1 --noclose -e rake db:migrate

else
konsole --workdir $1 --noclose -e rake db:migrate VERSION=$CHOICE
fi