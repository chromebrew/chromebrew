class InstallError < RuntimeError; end

def create_placeholder (*functions)
  # create_placeholder: create a placeholder for functions that will be used by crew later
  functions.each do |func|
    self.class_eval("def self.#{func.to_s}; end")
  end
end

def property (*properties)
  # property: like attr_accessor, but `=` is not needed to define a value
  # Examples:
  #   {prop_name}('example') # set {prop_name} to 'example'
  #   {prop_name}            # return the value of {prop_name}
  properties.each do |prop|
    self.class_eval <<~EOT
      def self.#{prop} (#{prop} = nil)
        @#{prop} = #{prop} if #{prop}
        @#{prop}
      end
    EOT
  end
end
