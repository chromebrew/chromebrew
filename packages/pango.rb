require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'https://pango.gnome.org/'
  @_ver = '1.50.14'
  version @_ver
  license 'LGPL-2+ and FTL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.14_armv7l/pango-1.50.14-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.14_armv7l/pango-1.50.14-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.14_i686/pango-1.50.14-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.14_x86_64/pango-1.50.14-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '80c4f94b3af1913342af608b36459b88fda898fd47f046dd04e3dd5ee9e45a52',
     armv7l: '80c4f94b3af1913342af608b36459b88fda898fd47f046dd04e3dd5ee9e45a52',
       i686: 'e4824ad37383eee09843bad8e197bafc940a30228357e2befaf93997c767d893',
     x86_64: '7f25de6365060477d569d2257cc41482ddf2b7a8cf25062aa2261f274ca6b22c'
  })

  depends_on 'cairo' => :build
  depends_on 'fribidi' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build # add this package to build gtk+, avoid compilation error
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'libxdmcp' => :build
  depends_on 'libxft' # R
  depends_on 'libxrender' # R
  depends_on 'xorg_proto' => :build

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
