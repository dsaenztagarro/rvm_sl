[![Build Status](https://travis-ci.org/dsaenztagarro/rvm-chef.svg?branch=master)](https://travis-ci.org/dsaenztagarro/rvm-chef)
[![Code Climate](https://codeclimate.com/github/dsaenztagarro/rvm-chef/badges/gpa.svg)](https://codeclimate.com/github/dsaenztagarro/rvm-chef)
[![Coverage Status](https://coveralls.io/repos/dsaenztagarro/rvm-chef/badge.svg?branch=master&service=github)](https://coveralls.io/github/dsaenztagarro/rvm-chef?branch=master)
[![Dependency Status](https://gemnasium.com/dsaenztagarro/rvm-chef.svg)](https://gemnasium.com/dsaenztagarro/rvm-chef)

rvm Cookbook
============

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
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['rvm']['keyserver']</tt></td>
    <td>String</td>
    <td>Key to import from key server</td>
    <td><tt>hkp://keys.gnupg.net</tt></td>
  </tr>
  <tr>
    <td><tt>['rvm']['rcev-keys']</tt></td>
    <td>String</td>
    <td>Import the keys with the given key IDs from a keyserver</td>
    <td><tt>409B6B1796C275462A1703113804BB82D39DC0E3</tt></td>
  </tr>
  <tr>
    <td><tt>['rvm']['user']['name']</tt></td>
    <td>String</td>
    <td>The user name for rvm user install</td>
    <td><tt>admin</tt></td>
  </tr>
  <tr>
    <td><tt>['rvm']['user']['password']</tt></td>
    <td>String</td>
    <td>The user password for rvm user install</td>
    <td><tt>admin</tt></td>
  </tr>
  <tr>
    <td><tt>['rvm']['user']['dir']</tt></td>
    <td>String</td>
    <td>The user folder for rvm user install</td>
    <td><tt>/home/admin</tt></td>
  </tr>
</table>

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

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: David Saenz Tagarro
