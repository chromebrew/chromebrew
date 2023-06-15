require 'package'
# build order: harfbuzz => freetype => fontconfig => pango.

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'https://pango.gnome.org/'
  version '1.50.14'
  license 'LGPL-2+ and FTL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.14_armv7l/pango-1.50.14-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.14_armv7l/pango-1.50.14-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.14_i686/pango-1.50.14-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.14_x86_64/pango-1.50.14-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1ce1cf1f0c7caf921d5d0781ae6758ee907e39d6f305653d761e0be63e152964',
     armv7l: '1ce1cf1f0c7caf921d5d0781ae6758ee907e39d6f305653d761e0be63e152964',
       i686: '488189887047f561ab1bd02065fab5781c3178ff6ea430bf07dad9db5c420b8a',
     x86_64: 'c984d03b58e8bcfb5a35e44be3be61f37efb3ceef4554fe9dab4a7cf86cf6b43'
  })

  depends_on 'cairo' => :build
  depends_on 'fribidi' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build # add this package to build gtk+, avoid compilation error
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'libxdmcp' => :build
  depends_on 'libxft' # R
  depends_on 'libxrender' # R
  depends_on 'xorg_proto' => :build
  depends_on 'cairo' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dinstall-tests=false \
    -Dcairo=enabled \
    -Dfreetype=enabled \
    -Dfontconfig=enabled \
    -Dlibthai=disabled \
    -Dgtk_doc=false builddir"
    # gtk-doc is set to false because I (@saltedcofii) am not
    # convinced anyone is reading them; it's accessable online anyway
    system 'meson configure builddir'
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  def self.check
    system "#{CREW_NINJA} -C builddir test || true"
  end
end
