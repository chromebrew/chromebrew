require 'package'

class Gcalculator < Package
  description 'GNOME desktop calculator'
  homepage 'https://wiki.gnome.org/Apps/Calculator'
  compatibility 'all'
  @_app = name.tr('_', '-')
  @_fullver = '3.38.2'
  @_mainver = @_fullver.rpartition('.')[0]
  @_url = "https://download.gnome.org/sources/#{@_app}/#{@_mainver}/#{@_app}-#{@_fullver}"
  version @_fullver
  source_url "#{@_url}.tar.xz"
  source_sha256 `curl -Ls #{@_url}.sha256sum | tail -n1 | cut -d ' ' -f1`.chomp

  depends_on 'setuptools' => :build
  depends_on 'gtk3'
  depends_on 'gtksourceview'
  depends_on 'itstool'
  depends_on 'libgee'
  depends_on 'libsoup'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
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
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/#{@_app}", "#{CREW_DEST_PREFIX}/bin/#{@_app}.elf"
    FileUtils.install @_app, "#{CREW_DEST_PREFIX}/bin/#{@_app}", mode: 0755
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
