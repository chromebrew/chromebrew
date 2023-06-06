require 'package'

class Gnome_calculator < Package
  description 'GNOME desktop calculator'
  homepage 'https://wiki.gnome.org/Apps/Calculator'
  @_ver = '43.0.1'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-calculator.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_calculator/43.0.1_armv7l/gnome_calculator-43.0.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_calculator/43.0.1_armv7l/gnome_calculator-43.0.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_calculator/43.0.1_i686/gnome_calculator-43.0.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_calculator/43.0.1_x86_64/gnome_calculator-43.0.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a6e5f0667f8ab02634ee3ff321155dc92dac7a974f9e20c4e9aa3c2c34dd1994',
     armv7l: 'a6e5f0667f8ab02634ee3ff321155dc92dac7a974f9e20c4e9aa3c2c34dd1994',
       i686: '33987c06251197bdb3e4cfc66fea2db9da26bb2726ee1dee299b296f15cc85a3',
     x86_64: '414afd75da3ffda9b37f3eddfc892686461ea174cce752017113700bdd76ec33'
  })

  depends_on 'python3' => :build
  depends_on 'py3_libxml2' => :build
  depends_on 'gtk3'
  depends_on 'gtksourceview'
  depends_on 'itstool'
  depends_on 'libgee'
  depends_on 'libhandy'
  depends_on 'libsoup'
  depends_on 'wayland'
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk4' # R
  depends_on 'gtksourceview_5' # R
  depends_on 'libadwaita' # R
  depends_on 'libxml2' # R
  depends_on 'mpc' # R
  depends_on 'mpfr' # R
  depends_on 'gcc_lib' # R
  gnome

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
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
