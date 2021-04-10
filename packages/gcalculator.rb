require 'package'

class Gcalculator < Package
  description 'GNOME desktop calculator'
  homepage 'https://wiki.gnome.org/Apps/Calculator'
  @_app = 'gnome-calculator'
  @_fullver = '3.38.2'
  @_mainver = @_fullver.rpartition('.')[0]
  @_url = "https://download.gnome.org/sources/#{@_app}/#{@_mainver}/#{@_app}-#{@_fullver}"
  version @_fullver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "#{@_url}.tar.xz"
  source_sha256 `curl -Ls #{@_url}.sha256sum | tail -n1 | cut -d ' ' -f1`.chomp

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gcalculator-3.38.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gcalculator-3.38.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gcalculator-3.38.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gcalculator-3.38.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f733de0413e40cf0e730a06eef727ea1ace4a92e0fe8f3fd0590c7c7cee017db',
     armv7l: 'f733de0413e40cf0e730a06eef727ea1ace4a92e0fe8f3fd0590c7c7cee017db',
       i686: '6a1a313f5a9ecf6538920b2c63fd1147657e0ed157d6cc676a11f0256420bf40',
     x86_64: 'ef3e8c4ef780fefa7a25d715c213f6717d387be9d141343328780ae93e3bec98',
  })

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
