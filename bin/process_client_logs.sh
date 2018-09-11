#!/bin/bash

cd $1

grep -wr "Failed password for" --exclude=failed_login_data.txt |
awk '{if($9 == "invalid"){print $1, $2, substr($3, 1, 2), $11, $13}
else{print $1, $2, substr($3, 1, 2), $9, $11}}' |
awk -F: '{print $2}' |
cat >> failed_login_data.txt
