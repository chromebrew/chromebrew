require 'package'

class Gnome_calculator < Package
  description 'GNOME desktop calculator'
  homepage 'https://wiki.gnome.org/Apps/Calculator'
  version '43.0.1'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-calculator.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6e5f0667f8ab02634ee3ff321155dc92dac7a974f9e20c4e9aa3c2c34dd1994',
     armv7l: 'a6e5f0667f8ab02634ee3ff321155dc92dac7a974f9e20c4e9aa3c2c34dd1994',
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

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure --no-pager builddir'
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.postinstall
    puts <<~EOT.lightblue

      To use the graphical calculator, execute 'gnome-calculator'

      To use the command line calculator, execute 'gcalccmd'
    EOT
  end
end
