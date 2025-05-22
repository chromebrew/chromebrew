require 'package'
require 'require_gem'

class Qmake < Package
  property :qmake_build_extras, :qmake_install_extras

  def self.build
    method_list = methods.grep(/#{superclass.to_s.downcase}_/).delete_if { |i| send(i).blank? }
    return if method_list.empty?

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

    system "QMAKE_CXX='g++ #{ARCH == 'x86_64' && Gem::Version.new(LIBC_VERSION.to_s) >= Gem::Version.new('2.35') ? File.join(CREW_LIB_PREFIX, 'libC.so.6').to_s : ''}' qmake"
    system 'make'
    @qmake_build_extras&.call
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
    @qmake_install_extras&.call
  end
end
