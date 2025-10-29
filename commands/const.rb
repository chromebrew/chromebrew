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
        Object.const_source_location(const).first == File.realpath(File.join(__dir__, '../lib/const.rb'))
      end.sort

      # Print a sorted list of the remaining constants used by crew.
      constants.each do |constant|
        puts "#{constant}=#{Object.const_get(constant.to_sym)}"
      end
    end
  end
end
