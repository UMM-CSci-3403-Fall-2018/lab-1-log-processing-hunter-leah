#!/bin/bash

cat html_components/country_dist_header.html >> $1/country_dist.html

find $1 -name "*failed_login_data*" -exec awk '{print $5}' {} + | sort | cat >> $1/sorted_ips.txt

join --nocheck-order etc/country_IP_map.txt $1/sorted_ips.txt | awk '{print $2}' | sort | uniq -c | awk '{print "data.addRow([\x27"$2"\x27, "$1"]);"}' | cat >> $1/country_dist.html

rm $1/sorted_ips.txt
