def property(*properties)
  properties.each do |prop|
    self.class_eval("def self.#{prop}(#{prop} = nil); @#{prop} = #{prop} if #{prop}; @#{prop}; end")
  end
end
