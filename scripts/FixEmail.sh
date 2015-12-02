#!/bin/bash
#
#       FixEmail.sh
#       
#       Copyright 2011 Francisco Hernandez <FJHernandez89@gmail.com>
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
#     

#---Variables---
ARGS=1
ACARG=$#
T01=$1
E_BADARGS=65

#---Check Arguments---
#echo "FixEmail.sh"
if [ "$ACARG" -ne "$ARGS" ] 
then 
	echo "Usage: 'FixEmail.sh' FILENAME"
	exit $E_BADARGS
fi

#---Fixing emails---
echo "Now fixing emails"

sed -e 's/\\n/\n/g' $1 > $1.new 
sed -e 's/\\r//g' $1.new > $1

#Not ready (supposed to clean up remaing Ruby code) !
#sed -e 's/\#<struct\sNet::IMAP::FetchData\sseqno=[0-9],\sattr={"FLAGS"=>\[:Seen\],\s"BODY\[TEXT\]"=>"\s//g' $1 >$1.new
#sed -e 's/"}>/==================================================================================/g' $1.new >$1

rm $1.new
