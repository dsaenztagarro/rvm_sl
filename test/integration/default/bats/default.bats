@test "installs the correct version of Ruby" {
  bash -l -c 'ruby --version | grep 2.0.0'
}
