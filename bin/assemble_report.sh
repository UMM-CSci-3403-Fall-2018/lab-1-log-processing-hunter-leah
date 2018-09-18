#!/bin/bash

html_directory=$1
temp=$(mktemp)
here=$(pwd)
cd $html_directory

cat country_dist.html hours_dist.html username_dist.html > $temp
cd $here

bash bin/wrap_contents.sh $temp  html_components/summary_plots $html_directory/failed_login_summary.html

rm $temp
