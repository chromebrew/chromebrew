require 'package'

class Adwaita_icon_theme < Package
  description 'Theme consisting of a set of icons for GTK+'
  homepage 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme'
  version '40.1.1'
  license 'LGPL-3 and CC-BY-SA-4.0'
  compatibility 'all'
  source_url 'https://download.gnome.org/core/41/41.rc/sources/adwaita-icon-theme-40.1.1.tar.xz'
  source_sha256 '0b6c436ed6ad9887a88ada1f72a0197b1eb73b020d8d344abab4c7fa7250f8f6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adwaita_icon_theme/40.1.1_armv7l/adwaita_icon_theme-40.1.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adwaita_icon_theme/40.1.1_armv7l/adwaita_icon_theme-40.1.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adwaita_icon_theme/40.1.1_i686/adwaita_icon_theme-40.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adwaita_icon_theme/40.1.1_x86_64/adwaita_icon_theme-40.1.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'adc3108c3520dedd11949bbcc1b39a573944d3f084166b385c93297f77c5aabe',
     armv7l: 'adc3108c3520dedd11949bbcc1b39a573944d3f084166b385c93297f77c5aabe',
       i686: 'c4f97fc424e02d37498be3e27237acd41f0051c101dec307c5635c07969461a9',
     x86_64: 'a900ebcf4874828df3891c23921154aa1681ba6690f951fbf75358f88f0ad458'
  })

  depends_on 'cantarell_fonts'
  depends_on 'gtk3'
  depends_on 'librsvg'
  depends_on 'gdk_pixbuf'
  depends_on 'vala' => :build
  depends_on 'xdg_base'

  def self.build
    # Need to make sure svg support is properly loaded otherwise build fails.
    system "env GDK_PIXBUF_MODULEDIR='#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders' \
    GDK_PIXBUF_MODULE_FILE='#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache' \
    gdk-pixbuf-query-loaders > #{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache"
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
