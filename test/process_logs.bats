#!/usr/bin/env bats

# Remove the temporary scratch directory to clean up after ourselves.
teardown() {
  rm -f failed_login_summary.html
}

# If this test fails, your script file doesn't exist, or there's
# a typo in the name, or it's in the wrong directory, etc.
@test "bin/process_logs.sh exists" {
  [ -f "bin/process_logs.sh" ]
}

# If this test fails, your script isn't executable.
@test "bin/process_logs.sh is executable" {
  [ -x "bin/process_logs.sh" ]
}

# If this test fails, your script either didn't run at all, or it
# generated some sort of error when it ran.
@test "bin/process_logs.sh runs successfully" {
  run bin/process_logs.sh log_files/*_secure.tgz
  [ "$status" -eq 0 ]
}

# If this test fails, your script didn't generate the correct HTML
# for the bar chart for the hour data from discovery and velcro.
@test "bin/process_logs.sh generates correct simple output" {
  bin/process_logs.sh log_files/*_secure.tgz
  BATS_TMPDIR=`mktemp --directory`
  sort test/summary_plots.html > $BATS_TMPDIR/target.txt
  sort failed_login_summary.html > $BATS_TMPDIR/sorted.txt
  run diff -wbB $BATS_TMPDIR/target.txt $BATS_TMPDIR/sorted.txt
  [ "$status" -eq 0 ]
}
