require 'package'

class Gcalculator < Package
  description 'Calculator for solving mathematical equations'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-calculator'
  version '3.38.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-calculator/-/archive/3.38.1/gnome-calculator-3.38.1.tar.bz2'
  source_sha256 '07dc348eef03f81fbe9c99f30836e0a1438942e5a9e79655772414eb5b09b691'

  binary_url ({
    
  })
  binary_sha256 ({
    
  })

  depends_on 'setuptools' => :build
  depends_on 'gtksourceview'
  depends_on 'itstool'
  depends_on 'libgee'
  depends_on 'libsoup'
  depends_on 'sommelier'

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    puts
    puts "To use the gui calculator, execute 'gnome-calculator'".lightblue
    puts
    puts "To use the cli calculator, execute 'gcalccmd'".lightblue
    puts
  end
end
