require 'fileutils'
require 'package'

class Autotools < Package
  property :configure_options, :pre_configure_options, :install_extras

  def self.build
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
      if `grep -q /usr/bin/file configure`
        puts 'Using filefix.'.orange
        system 'filefix'
      end
      @mold_linker_prefix_cmd = CREW_LINKER == 'mold' ? 'mold -run ' : ''
      system "#{@pre_configure_options} #{@mold_linker_prefix_cmd}./configure #{CREW_OPTIONS} #{@configure_options}"
    end
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    eval @install_extras if @install_extras
  end

  def self.check
    puts 'Testing with make check.'.orange if @run_tests
    system 'make', 'check' if @run_tests
  end

  def self.postinstall
    if @gnome
      puts 'Running Gnome post_installs...'.orange
      system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas" if File.file?("#{CREW_PREFIX}/bin/glib-compile-schemas")
      system "gio-querymodules #{CREW_LIB_PREFIX}/gio/modules" if File.file?("#{CREW_PREFIX}/bin/gio-querymodules")
      system "gtk-update-icon-cache -ft #{CREW_PREFIX}/share/icons/*", exception: false if File.file?("#{CREW_PREFIX}/bin/gtk-update-icon-cache")
      system "update-mime-database #{CREW_PREFIX}/share/mime" if File.file?("#{CREW_PREFIX}/bin/update-mime-database")
      return unless File.file?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")

      system 'gdk-pixbuf-query-loaders',
             '--update-cache'
    end
  end
end
