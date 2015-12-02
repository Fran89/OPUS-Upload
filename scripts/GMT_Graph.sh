#!/bin/bash
#
#       GMT_Graph.sh
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
##---Variables---
ARGS=3
ACARG=$#
T01=$1
E_BADARGS=65

#---Output Files---
Odx=$( echo $1 | sed 's/.dx/X.ps/g')
Ody=$( echo $2 | sed 's/.dy/Y.ps/g')
Odz=$( echo $3 | sed 's/.dz/Z.ps/g')

#---Verify Arguments---
if [ "$ACARG" -ne "$ARGS" ] 
then 
	echo "Usage: 'GMT_Graph.sh' DxFile DyFile DzFile"
	exit $E_BADARGS
fi

#---Define Ranges---
XxMin=$(awk 'min=="" || $1 < min {min=$1} END{ print min -1}'  $1) 
XxMax=$(awk 'max=="" || $1 > max {max=$1} END{ print max +1}'  $1)
XyMin=$(awk 'min=="" || $2 < min {min=$2} END{ print min -1}'  $1)
XyMax=$(awk 'max=="" || $2 > max {max=$2} END{ print max +1}'  $1)

YxMin=$(awk 'min=="" || $1 < min {min=$1} END{ print min -1}'  $2)
YxMax=$(awk 'max=="" || $1 > max {max=$1} END{ print max +1}'  $2)
YyMin=$(awk 'min=="" || $2 < min {min=$2} END{ print min -1}'  $2)
YyMax=$(awk 'max=="" || $2 > max {max=$2} END{ print max +1}'  $2)

ZxMin=$(awk 'min=="" || $1 < min {min=$1} END{ print min -1}'  $3)
ZxMax=$(awk 'max=="" || $1 > max {max=$1} END{ print max +1}'  $3)
ZyMin=$(awk 'min=="" || $2 < min {min=$2} END{ print min -1}'  $3)
ZyMax=$(awk 'max=="" || $2 > max {max=$2} END{ print max +1}'  $3)

RanX="-R$XxMin/$XxMax/$XyMin/$XyMax"
RanY="-R$YxMin/$YxMax/$YyMin/$YyMax"
RanZ="-R$ZxMin/$ZxMax/$ZyMin/$ZyMax"
Scal="-Jx.5"


#---Creating Graphs---
echo "Creating Graphs"

psbasemap $Scal $RanX -B:"# of Day":a5f5g1/:"NS-Disp (cm)":a5f5g1 -K > $Odx
psbasemap $Scal $RanY -B:"# of Day":a5f5g1/:"EW-Disp (cm)":a5f5g1 -K > $Ody
psbasemap $Scal $RanZ -B:"# of Day":a5f5g1/:"Vetical-Disp (cm)":a5f5g1 -K > $Odz

psxy $1 $Scal  $RanX -Sc.1 -Wthicker,255/0/0 -O >> $Odx
psxy $2 $Scal  $RanY -Sc.1 -Wthicker,255/0/0 -O >> $Ody
psxy $3 $Scal  $RanZ -Sc.1 -Wthicker,255/0/0 -O >> $Odz

