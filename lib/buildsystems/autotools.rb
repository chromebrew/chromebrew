require 'fileutils'
require_relative '../package'
require_relative '../require_gem'
require_relative '../report_buildsystem_methods'

class Autotools < Package
  property :autotools_configure_options, :autotools_pre_configure_options, :autotools_build_extras, :autotools_install_extras

  def self.build
    extend ReportBuildsystemMethods
    print_buildsystem_methods

    unless File.file?('Makefile') && CREW_CACHE_BUILD
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
      system "#{@autotools_pre_configure_options} ./configure #{CREW_CONFIGURE_OPTIONS} #{@autotools_configure_options}"
    end
    system 'make'
    @autotools_build_extras&.call
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    @autotools_install_extras&.call
  end

  def self.check
    puts 'Testing with make check.'.orange if @run_tests
    system 'make', 'check' if @run_tests
  end
end
