require_relative '../lib/const'

class Command
  def self.const(constant)
    if constant
      begin
        puts "#{constant}=#{Object.const_get(constant.to_sym)}"
      rescue NameError
        puts "Constant #{constant} not found"
      end
    else
      # Get all constants defined by const.rb
      constants = Object.constants.select do |const|
        Object.const_source_location(const).first == File.join(CREW_LIB_PATH, 'lib/const.rb')
      end.sort

      # Print a sorted list of the remaining constants used by crew.
      constants.each do |constant|
        puts "#{constant}=#{Object.const_get(constant.to_sym)}"
      end
    end
  end
end
