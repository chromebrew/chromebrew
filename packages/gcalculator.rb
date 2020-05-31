require 'package'

class Gcalculator < Package
  description 'Calculator for solving mathematical equations'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-calculator'
  version '3.36.0'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-calculator/-/archive/3.36.0/gnome-calculator-3.36.0.tar.bz2'
  source_sha256 '9d82e8b32cd3c41517d9bfc234b88359b1bef8f1bfa02994b622788272846b3a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gcalculator-3.36.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gcalculator-3.36.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gcalculator-3.36.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gcalculator-3.36.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6ef512061c2826d965bbc6be61d1070b96f815daedfb047f4ea958059825e1bc',
     armv7l: '6ef512061c2826d965bbc6be61d1070b96f815daedfb047f4ea958059825e1bc',
       i686: '7152af3ed58253c04bb23edfed46213107d1584f9fb6bb92a349139840ce099b',
     x86_64: 'b75a8c4fd588b2546389a1817a808420b68a73db71af95b2c3bb5d49e473ccbf',
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
