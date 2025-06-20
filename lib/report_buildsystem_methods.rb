module ReportBuildsystemMethods
  def print_buildsystem_methods
    boolean_list = available_boolean_properties
    method_list = methods.reject(&->(m) { boolean_list.include?(m.to_s.delete_suffix('?').to_sym) }).grep(/#{superclass.to_s.downcase}_/).select(&->(i) { send(i) })

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
