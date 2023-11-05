class InstallError < RuntimeError; end

def create_placeholder(*functions)
  # create_placeholder: create a placeholder for functions that will be used by crew later
  functions.each do |func|
    class_eval("def self.#{func}; end", __FILE__, __LINE__)
  end
end

def property(*properties)
  # property: like attr_accessor, but `=` is not needed to define a value
  # Examples:
  #   {prop_name}('example') # set {prop_name} to 'example'
  #   {prop_name}            # return the value of {prop_name}
  properties.each do |prop|
    class_eval <<~EOT, __FILE__, __LINE__ + 1
      def self.#{prop} (#{prop} = nil)
        @#{prop} = #{prop} if #{prop}
        @#{prop}
      end
    EOT
  end
end

def boolean_property(*boolean_properties)
  # boolean_property: if this exists in a package, it will return true
  # Examples:
  #   {prop_name}            # this will return #{prop_name} as true
  boolean_properties.each do |prop|
    class_eval <<~EOT, __FILE__, __LINE__ + 1
      def self.#{prop} (#{prop} = nil)
        @#{prop} = true if #{prop}
        !!@#{prop}
      end
    EOT
    instance_eval <<~EOY, __FILE__, __LINE__ + 1
      def self.#{prop}
        @#{prop} = true
      end
    EOY
    # Adds the symbol? method
    define_singleton_method("#{prop}?") do
      @prop = instance_variable_get("@#{prop}")
      !!@prop
    end
  end
end
