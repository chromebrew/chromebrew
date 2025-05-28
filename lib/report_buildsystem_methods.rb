module ReportBuildsystemMethods
  def print_buildsystem_methods
    method_list = methods.grep(/#{superclass.to_s.downcase}_/).delete_if { |i| send(i).blank? }
    unless method_list.empty?
      require_gem 'method_source'
      method_blocks = []
      method_strings = []
      method_list.sort.each do |method|
        @method_info = send method
        if @method_info.is_a? String
          method_strings << "#{method}: #{@method_info}".orange
        else
          method_blocks << @method_info.source.to_s.orange
        end
      end
      puts "Additional #{superclass.to_s.capitalize} options being used:".orange
      puts method_strings
      puts method_blocks
    end
  end
end
