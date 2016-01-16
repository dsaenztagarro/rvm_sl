@test "installs the correct version of Ruby" {
  ruby --version | grep 2.0.0
}
