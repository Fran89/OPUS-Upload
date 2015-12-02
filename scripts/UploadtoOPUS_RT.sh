#!/bin/bash
#       
#       UploadToOPUS.sh
#       
#       Copyright 2011 Francisco Hernandez <francisco@francisco-laptop>
#       
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#       
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#       
#       You should have received a copy of the GNU General Public License
#       along with this program; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA. 
#       This script uses RUBY to upload all of the OBS files in the current directory to OPUS (Static)

# Variables
email=$1			#E-mail where data will be sent
height=$2			#Height of the antena
counter=0
counter1=0
percent=0
cd $(dirname "${0}")
java -jar ./selenium-server.jar -singleWindow -browserSessionReuse &
sleep 20s

echo "This script uses RUBY to upload all of the OBS files in the current directory to OPUS (Static)
"
echo "Now changing directory to " $(dirname "${0}")"../updata"
echo ""

cd ../updata
fullpath=$(pwd)

for file in *.[1890][890]o
do
counter=$(expr $counter + 1)
done

for file in *.[1890][890]o
do
echo "Now uploading $file"

../scripts/UploadToOPUS.rb $email "$fullpath/$file" $height

counter1=$(expr $counter1 + 1)
percent=$(expr $counter1/$counter)
echo "Done uploading $file: $percent done!
"
echo "Now downloading e-mail
"
../scripts/DownloadFromOPUS.rb $server $user $pass $port >> $DataMail
mv $file ./old/$file
done

killall java

exit 0
