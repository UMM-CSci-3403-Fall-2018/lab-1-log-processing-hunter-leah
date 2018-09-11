#!/bin/bash

bin/wrap_contents.sh (cat $1/username_dist.html $1/hours_dist.html $1/country_dist.html) summary_plots.html failed_login_summary.html
