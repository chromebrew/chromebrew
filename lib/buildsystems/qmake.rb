require 'package'
require 'require_gem'

class Qmake < Package
  property :qmake_build_extras, :qmake_install_extras

  def self.build
    puts "Additional #{superclass.to_s.capitalize} options being used:".orange
    method_list = methods.grep(/qmake_/).delete_if { |i| send(i).blank? }
    require_gem 'method_source'
    method_list.each do |method|
      @method_info = send method
      if @method_info.is_a? String
        puts "#{method}: #{@method_info}".orange
      else
        puts @method_info.source.display
      end
    end
    system "QMAKE_CXX='g++ #{ARCH == 'x86_64' && Gem::Version.new(LIBC_VERSION.to_s) >= Gem::Version.new('2.35') ? File.join(CREW_LIB_PREFIX, 'libC.so.6').to_s : ''}' qmake"
    system 'make'
    @qmake_build_extras&.call
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
    @qmake_install_extras&.call
  end
end
