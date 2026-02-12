require 'fileutils'
require_relative '../package'
require_relative '../require_gem'
require_relative '../report_buildsystem_methods'

class Autotools < Package
  boolean_property :autotools_make_j1
  property :autotools_build_relative_dir, :autotools_configure_options, :autotools_configure_modifications, :autotools_install_options, :autotools_pre_configure_options, :autotools_build_extras, :autotools_install_extras

  def self.prebuild_config_and_report
    @autotools_build_relative_dir ||= '.'
    @autotools_install_options ||= "DESTDIR=#{CREW_DEST_DIR}"
    @autotools_install_options = @autotools_install_options.split.unshift("DESTDIR=#{CREW_DEST_DIR}").uniq.join(' ')
    @crew_autotools_configure_options = defined?(@autotools_configure_modifications) && @autotools_configure_modifications.is_a?(Array) ? CREW_CONFIGURE_OPTIONS.gsub(@autotools_configure_modifications[0], @autotools_configure_modifications[1]) : CREW_CONFIGURE_OPTIONS

    extend ReportBuildsystemMethods

    print_buildsystem_methods
  end

  def self.build
    Dir.chdir(@autotools_build_relative_dir) do
      # Some packages, such as ocaml, have a dummy makefile, so check that this is actually a generated makefile.
      unless File.file?('Makefile') && File.read('Makefile', 500).include?('generated') && CREW_CACHE_BUILD
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
        system 'filefix', exception: false unless @no_filefix
        system "#{@autotools_pre_configure_options} ./configure #{@crew_autotools_configure_options} #{@autotools_configure_options}"
      end

      # Add "-j#" argument to "make" at compile-time, if necessary.
      if @autotools_make_j1
        system 'make', '-j1'
      else
        system 'make', '-j', CREW_NPROC
      end

      @autotools_build_extras&.call
    end
  end

  def self.install
    Dir.chdir(@autotools_build_relative_dir) do
      system "make #{@autotools_install_options} install"
      @autotools_install_extras&.call
    end
  end

  def self.check
    return unless @run_tests

    Dir.chdir(@autotools_build_relative_dir) do
      puts 'Testing with make check.'.orange
      system "make #{@autotools_install_options} check"
    end
  end
end
