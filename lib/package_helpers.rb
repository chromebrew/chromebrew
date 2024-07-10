class InstallError < RuntimeError; end

def create_placeholder(*functions)
  # create_placeholder: create a placeholder for functions that will be used by crew later
  functions.each do |funcName|
    define_singleton_method(funcName) {}
  end
end

def property(*properties)
  # property: like attr_accessor, but `=` is not needed to define a value
  # Examples:
  #   {prop_name}('example') # set {prop_name} to 'example'
  #   {prop_name}            # return the value of {prop_name}
  properties.each do |propName|
    define_singleton_method(propName) do |propValue = nil, &block|
      propVarName = "@#{propName}"

      if block
        # store the block if a block is provided
        instance_variable_set(propVarName, block)
      elsif propValue
        instance_variable_set(propVarName, propValue)
      else
        # return current value if nothing is provided
        return instance_variable_get(propVarName)
      end
    end
  end
end

def boolean_property(*boolean_properties)
  # boolean_property: if this exists in a package, it will return true
  # Examples:
  #   {prop_name}            # this will return #{prop_name} as true

  define_singleton_method(:available_boolean_properties) do
    # available_boolean_properties: Return all available boolean properties for use in commands/{prop,help}.rb
    # Usage:
    #   puts Package.available_boolean_properties => [:conflicts_ok, ...]
    return boolean_properties
  end

  boolean_properties.each do |propName|
    propVarName = "@#{propName}"

    # Adds the self.{symbol} method
    define_singleton_method(propName) do
      instance_variable_set(propVarName, true)
    end

    # Adds the self.{symbol}? method
    define_singleton_method("#{propName}?") do
      return !!instance_variable_get(propVarName)
    end
  end
end
