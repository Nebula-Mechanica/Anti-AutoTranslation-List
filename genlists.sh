#!/bin/bash
# Generation of full and simple (without css) list
# To add domains just write them it in the end of domains.txt file and run this script
IFS=$'\n'

#Google
FILTER_TEMPLATE[1]='google.*##.rc:has(a[href*="@@@/"])'
FILTER_TEMPLATE[2]='google.*##.nrgt:has(a[href*="@@@/"])'
FILTER_TEMPLATE[3]='google.*##.xpd.mnr-c:has(a[href*="@@@/"])'
#DuckDuckGo
FILTER_TEMPLATE[4]='duckduckgo.com##.result[data-domain$="@@@"]'
FILTER_TEMPLATE[5]='duckduckgo.com##.web-result:has(a[href*="@@@/"])'
#DuckDuckGo Lite
FILTER_TEMPLATE[6]='duckduckgo.com##form[action="/lite/"] tbody tr:has(td a[class="result-link"][href*="@@@/"])'
FILTER_TEMPLATE[7]='duckduckgo.com##form[action="/lite/"] tbody tr:has(td a[class="result-link"][href*="@@@/"]) + tr'
FILTER_TEMPLATE[8]='duckduckgo.com##form[action="/lite/"] tbody tr:has(td a[class="result-link"][href*="@@@/"]) + tr + tr'
#Startpage
FILTER_TEMPLATE[9]='startpage.com##.w-gl__result:has(.w-gl__result-url-container a[href*="@@@/"])'

WORKDIR="./workdir"
HEADER="header.txt"
DOMAINS_LIST="domains.txt"
SIMPLE_LIST="anti-autotranslation-list.txt"
CSS_LIST="anti-autotranslation-list-css.txt"
FULL_LIST="anti-autotranslation-list-full.txt"

sort -o $DOMAINS_LIST $DOMAINS_LIST
rm $WORKDIR/$CSS_LIST $FULL_LIST $SIMPLE_LIST
for line in $(cat $DOMAINS_LIST|tr -d '\r')
do
	if [ ! `echo $line|cut -c1` = "!" ]; then
		for filter in "${FILTER_TEMPLATE[@]}"
		do
			echo $filter|sed "s|@@@|$line|g" >> $WORKDIR/$CSS_LIST
		done
	fi
done
cat $WORKDIR/$HEADER > $SIMPLE_LIST
cat $DOMAINS_LIST >> $SIMPLE_LIST
cat $SIMPLE_LIST > $FULL_LIST
echo >> $FULL_LIST
echo >> $FULL_LIST
echo "# CSS Rules" >> $FULL_LIST
echo >> $FULL_LIST
cat $WORKDIR/$CSS_LIST >> $FULL_LIST
