require 'package'

class CMake < Package
  property :cmake_options, :pre_cmake_options

  def self.build
    puts "Additional cmake_options being used: #{@pre_cmake_options.nil? ? '<no pre_cmake_options>' : @pre_cmake_options} #{@cmake_options.nil? ? '<no cmake_options>' : @cmake_options}".orange
    @crew_cmake_options = @no_lto ? CREW_CMAKE_FNO_LTO_OPTIONS : CREW_CMAKE_OPTIONS
    @mold_linker_prefix_cmd = CREW_LINKER == 'mold' ? 'mold -run' : ''
    system "#{@pre_cmake_options} #{@mold_linker_prefix_cmd} cmake -B builddir -G Ninja #{@crew_cmake_options} #{@cmake_options}"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
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
      return unless File.file?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")

      system 'gdk-pixbuf-query-loaders',
             '--update-cache'
    end
  end
end
