#!/bin/bash

tempDir=$(mktemp -d)
here=$(pwd)

for var in "$@";
do
	mkdir -p $tempDir/${var%_*}
	tar -zxvf $var -C $tempDir/${var%_*}
	./bin/process_client_logs.sh $tempDir/${var%_*}
done

./bin/create_username_dist.sh $tempDir
./bin/create_hours_dist.sh $tempDir
./bin/create_country_dist.sh $tempDir
./bin/assemble_report.sh $tempDir

cd $here
mv $tempDir/failed_login_summary.html $here

rm -rf $tempDir
