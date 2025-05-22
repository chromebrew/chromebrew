require 'fileutils'
require 'package'
require 'require_gem'

class Autotools < Package
  property :configure_options, :pre_configure_options, :configure_build_extras, :configure_install_extras

  def self.build
    puts "Additional #{superclass.to_s.capitalize} options being used:".orange
    method_list = methods.grep(/configure_/).delete_if { |i| send(i).blank? }
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
    puts method_strings
    puts method_blocks

    unless File.file?('Makefile') && CREW_CACHE_BUILD
      puts "Additional configure_options being used: #{@pre_configure_options.nil? ? '<no pre_configure_options>' : @pre_configure_options} #{@configure_options.nil? ? '<no configure_options>' : @configure_options}".orange
      # Run autoreconf if necessary
      unless File.executable? './configure'
        if File.executable? './autogen.sh'
          system 'NOCONFIGURE=1 ./autogen.sh --no-configure || NOCONFIGURE=1 ./autogen.sh'
        elsif File.executable? './bootstrap'
          system 'NOCONFIGURE=1 ./bootstrap --no-configure || NOCONFIGURE=1 ./bootstrap'
        else
          system 'autoreconf -fiv'
        end
      end
      abort 'configure script not found!'.lightred unless File.file?('configure')
      FileUtils.chmod('+x', 'configure')
      system 'filefix', exception: false
      system "#{@pre_configure_options} ./configure #{CREW_CONFIGURE_OPTIONS} #{@configure_options}"
    end
    system 'make'
    @configure_build_extras&.call
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    @configure_install_extras&.call
  end

  def self.check
    puts 'Testing with make check.'.orange if @run_tests
    system 'make', 'check' if @run_tests
  end
end
