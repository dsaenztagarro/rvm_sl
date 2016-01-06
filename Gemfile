source 'https://rubygems.org'

# nokogiri locked to chefdk version in ChefDK of Travis CI
gem 'nokogiri', '1.6.7'

# net-ssh locked to avoid check_version_conflict in Travis CI
gem 'net-ssh', '2.7'

group :development do
  gem 'travis', '~> 1.8.0'
end

group :kitchen_common do
  gem 'test-kitchen', '~> 1.4.2'
end

group :kitchen_vagrant do
  gem 'kitchen-vagrant', '~> 0.19.0'
end

group :kitchen_cloud do
  gem 'kitchen-digitalocean', '~> 0.9.5'
end

# Executables provided by ChefDK
group :chef do
  gem 'berkshelf', '~> 4.0.1'
  gem 'chefspec', '~> 4.4.0'
  gem 'librarian-chef'
  gem 'foodcritic', '~> 5.0.0'
  gem 'rspec', '~> 3.4.0'
  gem 'rubocop', '~> 0.35.0'
  gem 'serverspec', '~> 2.24.1'
end

group :test do
  gem 'reek', '~> 3.7.0'
  gem 'cane', '~> 2.6.2'
  gem 'coveralls', '~> 0.8.10'
  gem 'simplecov', '~> 0.11.0'
  gem 'simplecov-console', '~> 0.2.0'
end
