@test "installs the correct version of Ruby" {
  ruby --version | grep 2.3.0
}
