[![Cookbook Version](https://img.shields.io/cookbook/v/rvm_sl.svg)](https://community.opscode.com/cookbooks/rvm_sl)
[![Build Status](https://travis-ci.org/dsaenztagarro/rvm_sl.svg?branch=master)](https://travis-ci.org/dsaenztagarro/rvm_sl)
[![Code Climate](https://codeclimate.com/github/dsaenztagarro/rvm_sl/badges/gpa.svg)](https://codeclimate.com/github/dsaenztagarro/rvm_sl)
[![Coverage Status](https://coveralls.io/repos/dsaenztagarro/rvm_sl/badge.svg?branch=master&service=github)](https://coveralls.io/github/dsaenztagarro/rvm_sl?branch=master)
[![Dependency Status](https://gemnasium.com/dsaenztagarro/rvm_sl.svg)](https://gemnasium.com/dsaenztagarro/rvm_sl)

rvm_sl Cookbook
===============

Manages per-user RVMs and manages installed Rubies.

Requirements
------------

#### Platforms
- Ubuntu 14.04 LTS

#### Chef
- Chef 12.2.0

Attributes
----------

#### rvm::user_install

See `attributes/user_install.rb` for default values.

* `node['rvm']['keyserver']` - Key to import from key server
* `node['rvm']['rcev-keys']` - Import the keys with the given key IDs from a keyserver
* `node['rvm']['user']['name']` - The user name for rvm user install
* `node['rvm']['user']['password']` - The user password for rvm user install
* `node['rvm']['user']['dir'] - The user folder for rvm user install

Resources
---------

Example install ruby 2.2.3 as default for vagrant user:

```ruby
rvm_rubies 'ruby-2.2.3' do
  default true
  home '/home/vagrant'
  user_name 'vagrant'
  version '2.2.3'
end
```

Usage
-----
#### rvm::user_install

Just include `rvm::user_install` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[rvm::user_install]"
  ]
}
```

Sharing
-------

```
knife cookbook site share "rvm_sl" "Package Management"
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: David Saenz Tagarro
