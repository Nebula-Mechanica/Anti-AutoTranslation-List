#!/bin/bash
IFS=$'\n'
FILTER_TEMPLATE[1]='google.*##.rc:has(a[href*="@@@/"])'
FILTER_TEMPLATE[2]='google.*##.nrgt:has(a[href*="@@@/"])'
FILTER_TEMPLATE[3]='google.*##.xpd.mnr-c:has(a[href*="@@@/"])'
DOMAINS_LIST="anti-autotranslation-list.txt"
CSS_LIST="anti-autotranslation-list-css.txt"
FULL_LIST="anti-autotranslation-list-full.txt"
rm $CSS_LIST $FULL_LIST
for line in $(cat $DOMAINS_LIST|tr -d '\r')
do
	if [ ! `echo $line|cut -c1` = "!" ]; then
		#echo $FILTER_TEMPLATE|sed "s|@@@|$line|"|tee -a $CSS_LIST
		for filter in "${FILTER_TEMPLATE[@]}"
		do
			echo $filter|sed "s|@@@|$line|g" >> $CSS_LIST
		done
	fi
done
cat $DOMAINS_LIST > $FULL_LIST
echo >> $FULL_LIST
echo >> $FULL_LIST
echo "# CSS Rules" >> $FULL_LIST
echo >> $FULL_LIST
cat $CSS_LIST >> $FULL_LIST