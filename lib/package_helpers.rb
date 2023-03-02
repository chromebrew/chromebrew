class InstallError < RuntimeError; end

def attr_reader_with_default(**vars)
  # attr_reader_with_default: like attr_reader but with the ability to specify a default value
  vars.each_pair do |varName, defaultValue|
    class_eval("def #{varName}; return ( @#{varName} || #{defaultValue} ); end", __FILE__, __LINE__)
  end
end

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

def reload_constants
  warn_level = $VERBOSE
  $VERBOSE = nil
  load "#{CREW_LIB_PATH}lib/const.rb"
  $VERBOSE = warn_level
end
