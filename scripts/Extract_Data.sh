#!/bin/bash

## 06-02-2011, for 2 year data, 06/01/2009-05/31/2011
## 05-25-2011, notice the difference between NAD_83 and ITRF00, for landslide purpose,
## should always use NAD_83. notice for w7
##This will convert Mbox data to a database
###useage---- ./bob_extract_S_mbox.sh 24h_all.mbox

##---Variables---
ARGS=1
ACARG=$#
T01=$1
E_BADARGS=65

##---Input File---
echo "Input file: " $1

##---Output File---
output=$( echo $1 | sed -e 's/.txt/.xyz/g')
echo "Output file: " $output

echo "Email to Database"
if [ "$ACARG" -ne "$ARGS" ] 
then 
	echo "Usage: 'Extract_Data.sh' FILENAME"
	exit $E_BADARGS
fi

## Uncomment if you want to set up the output file
#echo "Filename START North(m) Sigma-N(m) East(m) Sigma-E(m) Vertical(m) Sigma-V(m) Ref1 Ref2 Ref3" > $output

cat $1 | while read line
do 
if echo $line |grep -q "NGS OPUS SOLUTION REPORT"
then
	echo "Start a Day! $line"

## w1--Rinex File Name
elif echo $line | grep -q "RINEX FILE:"
then
	echo "$line" |awk '{print $3}' > w1
        ww1=$(tail -1 w1)
        echo $ww1

## w2--Start Time
elif echo $line | grep -q "START:"
then
#	echo "$line" | grep -o "[0-9][0-9][0-9][0-9]/[0-9][0-9]/[0-9][0-9] " >> $outfiled
        echo "$line" | awk '{print $7}' > w2
        ww2=$(tail -1 w2)    

## w6--Sigma X, Easting
elif echo $line | grep  -q "X: " 
then
#	echo "$line" >> $outfilex
        echo "$line" | awk '{print $3}' > w6   
#       rm (m)
	ww6=$(sed -e 's/(m)//' w6)   
#	ww6=$(tail -1 w6)

## w4--Sigma Y, Northing
elif echo $line | grep  -q "Y: " 
then
	echo "$line" | awk '{print $3}' > w4
        ww4=$(sed -e 's/(m)//' w4)
	
## w7--Height, w8--sigma height, use NAD_83
elif echo $line | grep  -q "EL HGT: " 
then
	echo "$line" | awk '{print $3}' > w7
	echo "$line"| awk '{print $4}' > w8
#	sed -e 's/(m)//' w7 
#	sed -e 's/(m)//' w8 
        ww7=$(sed -e 's/(m)//' w7)
        ww8=$(sed -e 's/(m)//' w8)

## w3--Northing
elif echo $line | grep  -q "Northing " 
then
#	echo "$line" | grep -o "[0-9][0-9][0-9][0-9][0-9][0-9][0-9].[0-9][0-9][0-9] " >> $outfilen
        echo "$line" | awk '{print $4}' > w3
	ww3=$(tail -1 w3)

## w5--Easting
elif echo $line | grep  -q "Easting " 
then
#	echo "$line" | grep -o -m 1 "[0-9][0-9][0-9][0-9][0-9][0-9].[0-9][0-9][0-9] " >> $outfilee
	echo "$line" | awk '{print $4}' > w5
        ww5=$(tail -1 w5)

## w9, w10, w11--Reference site 1, 2, 3
elif echo $line | grep -q "[D,V,M,A][A-Z][0-9][0-9][0-9][0-9] "
then
        echo "$line"| awk '{print $2}' >> w11

### write out now!!

elif echo $line | grep -q "NEAREST NGS PUBLISHED CONTROL POINT"
then
ww11=$(tail -1 w11)
##rm the last row
sed '$d' < w11 >w10
ww10=$(tail -1 w10)
sed '$d'< w10 >w9
ww9=$(tail -1 w9)
rm w11

echo "$ww1 $ww2 $ww3 $ww4 $ww5 $ww6 $ww7 $ww8 $ww9 $ww10 $ww11" >> $output
rm w1 w2 w3 w4 w5 w6 w7 w8 w9 w10    
fi
done

exit 0

## sort according to the second column
 cp $output test.opus
 sort -k2n test.opus > tmp.sort
 cp tmp.sort $output
 
 rm w1 w2 w3 w4 w5 w6 w7 w8 w9 w10
 cat STOP >> $output
