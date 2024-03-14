require 'package'

class Meson < Package
  property :meson_options, :pre_meson_options, :meson_install_extras

  def self.build
    puts "Additional meson_options being used: #{@pre_meson_options.nil? ? '<no pre_meson_options>' : @pre_meson_options} #{@meson_options.nil? ? '<no meson_options>' : @meson_options}".orange
    @crew_meson_options = @no_lto ? CREW_MESON_FNO_LTO_OPTIONS : CREW_MESON_OPTIONS
    @mold_linker_prefix_cmd = CREW_LINKER == 'mold' ? 'mold -run' : ''
    system "#{@pre_meson_options} #{@mold_linker_prefix_cmd} meson setup #{@crew_meson_options} #{@meson_options} builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    eval @meson_install_extras if @meson_install_extras
  end

  def self.check
    puts "Testing with #{CREW_NINJA} test.".orange if @run_tests
    system "#{CREW_NINJA} -C builddir test" if @run_tests
  end

  def self.postinstall
    if @gnome
      puts 'Running Gnome post_installs...'.orange
      system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas" if File.file?("#{CREW_PREFIX}/bin/glib-compile-schemas")
      system "gio-querymodules #{CREW_LIB_PREFIX}/gio/modules" if File.file?("#{CREW_PREFIX}/bin/gio-querymodules")
      system "gtk-update-icon-cache -ft #{CREW_PREFIX}/share/icons/*", exception: false if File.file?("#{CREW_PREFIX}/bin/gtk-update-icon-cache")
    end
  end
end
