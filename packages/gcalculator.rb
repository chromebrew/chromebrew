require 'package'

class Gcalculator < Package
  description 'Calculator for solving mathematical equations'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-calculator'
  version '3.38.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-calculator/-/archive/3.38.1/gnome-calculator-3.38.1.tar.bz2'
  source_sha256 '33706fe3ade10b58e39c008f005a5bcca1b59239047b8c8f3ed595d0b7bd6894'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gcalculator-3.38.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gcalculator-3.38.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gcalculator-3.38.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gcalculator-3.38.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1ab4852cb55661918bc646bf6b1ca1ecf153c3fcc78d46cf13b1e7bc830ee69d',
     armv7l: '1ab4852cb55661918bc646bf6b1ca1ecf153c3fcc78d46cf13b1e7bc830ee69d',
       i686: '0eb813d120d974365d2910e9a21bee9bdb6e533b0d21e26510b40cbe09d3c4ca',
     x86_64: '8b1478a211443794b6aba531b30ff9359080cb580e5214d27d8df97beac3c0ec',
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
