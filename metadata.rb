name             'rvm_sl'
maintainer       'David Saenz Tagarro'
maintainer_email 'david.saenz.tagarro@gmail.com'
license          'All rights reserved'
description      'Installs/Configures rvm'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'

recipe 'rvm::user_install', 'User installation of rvm'

%w(debian ubuntu).each { |os| supports os }

source_url 'https://github.com/dsaenztagarro/rvm_sl' if respond_to?(:source_url)
issues_url 'https://github.com/dsaenztagarro/rvm_sl/issues' if respond_to?(:issues_url)
