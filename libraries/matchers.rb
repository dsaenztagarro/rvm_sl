if defined?(ChefSpec)

  def create_rvm_rubies(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:rvm_rubies, :create, resource_name)
  end

end
