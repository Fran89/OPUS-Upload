#!/bin/bash
#
#       Run.sh
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

#------------------------Please configure this------------------------------


email='DATA_EMAIL@PROVIDER'	# E-mail where data will be sent
height=0.0			# Height of the antena
user='DATA_EMAIL@PROVIDER'	# Username in e-mail server
pass='DATA_PASSWORD'		# Password of e-mail server
port=993			# Port of e-mail server
server='imap.gmail.com'		# Server Imap Address
Dividend=0.001			# Dividen by which you want the resolution
				# in the graph(example .001 for cm, 1 for m)


#--Do not change values bellow this line unless you know what you are doing-

cd $(dirname "${0}")
Fullpath=$(pwd)					# FullPath to this folder
DataMail=$Fullpath'/downdata/opus.txt'		# Temp Address for email 
						# (Can be configured)

DataXYZ=$(echo $DataMail | sed 's/txt/xyz/g' )	# XYZ File 
						# (Automatically Generated)
DataGMT=$(echo $DataMail | sed 's/txt/gmt/g' )	# GMT File 
						# (Automatically Generated)

DataX=$(echo $DataMail | sed 's/txt/dx/g' )	# Dx Plot (Auto Gen)
DataY=$(echo $DataMail | sed 's/txt/dy/g' )	# Dy Plot (Auto Gen)
DataZ=$(echo $DataMail | sed 's/txt/dz/g' )	# Dz Plot (Auto Gen)

export port server user pass DataMail		# Exports various variables 
						# for scripts

rm $DataXYZ $DataGMT

#./scripts/UploadtoOPUS_RT.sh $email $height
#./scripts/FixEmail.sh $DataMail
./scripts/Extract_Data.sh $DataMail
./scripts/XYZ_To_GMT.sh $DataXYZ $Dividend
./scripts/GMT_Graph.sh $DataX $DataY $DataZ

