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
source ~/.bash_profile
cd $1
cd db/migrate/
OPT="ALL"
for i in *; do
NUM=`echo "$i" | cut -d_ -f1`
NAME=`echo "$i"`
OPT="$OPT $NAME"
done
CHOICE=`zenity --title="Choose Migration" --list --text="Choose Migration" --column="Migrations" $OPT`
if [ $CHOICE = "ALL" ]; then
#konsole --workdir $1 --noclose -e rake db:migrate
  gnome-terminal --window --profile=rails --command=/home/coteyr/.bin/rails-migrate.sh 'all'
else
#konsole --workdir $1 --noclose -e rake db:migrate VERSION=$CHOICE
  gnome-terminal --window --profile=rails --command=/home/coteyr/.bin/rails-migrate.sh "$CHOICE"
fi
echo $CHOICE
