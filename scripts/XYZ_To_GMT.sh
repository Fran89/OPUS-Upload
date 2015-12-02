#!/bin/bash
#
#       XYZ_to_GMT.sh
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
ARGS=2
ACARG=$#
T01=$1
E_BADARGS=65

#---Check Arguments---
#echo "FixEmail.sh"
if [ "$ACARG" -ne "$ARGS" ] 
then 
	echo "Usage: 'XYZ_to_GMT.sh' FILENAME Dividend"
	exit $E_BADARGS
fi

echo "Now normalizing and creating GMT format"
#---Input file---
echo "Input file: " $1
#---Output file---
output=$(echo $1 | sed -e 's/xyz/gmt/g')
dx=$(echo $1 | sed -e 's/xyz/dx/g')
dy=$(echo $1 | sed -e 's/xyz/dy/g')
dz=$(echo $1 | sed -e 's/xyz/dz/g')
echo "Output file: " $output
echo \

awk '{print $3,$5,$7}' $1 > $output.temp
Xcenter=$(awk '{if (NR == 1) print $1}' $output.temp)
echo "X Centered in: " $Xcenter
Ycenter=$(awk '{if (NR == 1) print $2}' $output.temp)
echo "Y Centered in: " $Ycenter
Zcenter=$(awk '{if (NR == 1) print $3}' $output.temp)
echo "Z Centered in: " $Zcenter

awk -v Xcenter=$Xcenter -v Ycenter=$Ycenter -v Zcenter=$Zcenter -v div=$2 '{print NR,($1-Xcenter)/div,($2-Ycenter)/div,($3-Zcenter)/div}' $output.temp > $output

awk '{print $1, $2}' $output > $dx
awk '{print $1, $3}' $output > $dy
awk '{print $1, $4}' $output > $dz

rm $output.temp






