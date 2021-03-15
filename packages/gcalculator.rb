require 'package'

class Gcalculator < Package
  description 'GNOME desktop calculator'
  homepage 'https://wiki.gnome.org/Apps/Calculator'
  compatibility 'all'
  @_app = 'gnome-calculator'
  @_ver = '3.38.2'
  @_url = "https://download.gnome.org/sources/#{@_app}/#{@_ver.rpartition('.')[0]}/#{@_app}-#{@_ver}"
  version @_ver + '-1'
  source_url @_url + '.tar.xz'

  depends_on 'setuptools' => :build
  depends_on 'gtk3'
  depends_on 'gtksourceview'
  depends_on 'itstool'
  depends_on 'libgee'
  depends_on 'libsoup'
  
  def self.preflight
    source_sha256 `curl -Ls #{@_url}.sha256sum | tail -n1 | cut -d' ' -f1`.chomp
  end

  def self.build
    @_prefix = "#{CREW_PREFIX}/Applications/#{self.name}/"
    
    system "meson #{CREW_MESON_LTO_OPTIONS.gsub(CREW_PREFIX, @_prefix)} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    @_wrapper = <<~EOF
      #!/bin/sh
      WAYLAND_DISPLAY=wayland-0
      GDK_BACKEND=wayland
      CLUTTER_BACKEND=wayland
      exec #{@_app}.elf "$@"
    EOF
    File.write(@_app, @_wrapper)
    FileUtils.mv "#{CREW_DEST_DIR}/#{@_prefix}/bin/#{@_app}", "#{CREW_DEST_DIR}/#{@_prefix}/bin/#{@_app}.elf"
    FileUtils.install @_app, "#{CREW_DEST_DIR}/#{@_prefix}/bin/#{@_app}", mode: 0755
    # create symlinks
    Dir.chdir "#{CREW_DEST_DIR}/#{@_prefix}" do
      system "find . -type d -exec mkdir -p #{CREW_DEST_PREFIX}/{} \\;"
      system "find . -type f -exec ln -s \"/#{@_prefix}/\"{} \"#{CREW_DEST_PREFIX}/\"{} \\;"
    end
  end

  def self.postinstall
    system 'gdk-pixbuf-query-loaders --update-cache'
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    puts
    puts "To use the graphical calculator, execute 'gnome-calculator'".lightblue
    puts
    puts "To use the command line calculator, execute 'gcalccmd'".lightblue
    puts
  end
end
