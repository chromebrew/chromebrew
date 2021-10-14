require 'package'

class Gnome_calculator < Package
  description 'GNOME desktop calculator'
  homepage 'https://wiki.gnome.org/Apps/Calculator'
  @_ver = '41.0'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://download.gnome.org/sources/gnome-calculator/#{@_ver.rpartition('.')[0]}/gnome-calculator-#{@_ver}.tar.xz"
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-calculator.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_calculator/41.0_armv7l/gnome_calculator-41.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_calculator/41.0_armv7l/gnome_calculator-41.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_calculator/41.0_x86_64/gnome_calculator-41.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3360a1f8ff9d8cdcd7bf9f951d4ab86f60568ce46332e7780d1e4998e7361d8d',
     armv7l: '3360a1f8ff9d8cdcd7bf9f951d4ab86f60568ce46332e7780d1e4998e7361d8d',
     x86_64: 'e964edff1e49d225e1db6477b0c372d204afdd78a55512617a4d62fb5445f29b'
  })

  depends_on 'py3_setuptools' => :build
  depends_on 'py3_libxml2' => :build
  depends_on 'gtk3'
  depends_on 'gtksourceview'
  depends_on 'itstool'
  depends_on 'libgee'
  depends_on 'libhandy'
  depends_on 'libsoup'
  depends_on 'wayland'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "update-mime-database #{CREW_PREFIX}/share/mime"
    system 'gdk-pixbuf-query-loaders --update-cache'
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"

    puts <<~EOT.lightblue

      To use the graphical calculator, execute 'gnome-calculator'

      To use the command line calculator, execute 'gcalccmd'
    EOT
  end
end
