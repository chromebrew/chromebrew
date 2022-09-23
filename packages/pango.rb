require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'https://pango.gnome.org/'
  @_ver = '1.50.10'
  version @_ver
  license 'LGPL-2+ and FTL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.10_armv7l/pango-1.50.10-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.10_armv7l/pango-1.50.10-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.10_i686/pango-1.50.10-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.10_x86_64/pango-1.50.10-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '53ef271e640894edfe28064d33001b940e2b696519f58b587bf7abe605a8b2f9',
     armv7l: '53ef271e640894edfe28064d33001b940e2b696519f58b587bf7abe605a8b2f9',
       i686: 'd84a0a3efe1f1aefb67d8a88f962db89475e3fc581952734920c2f1b3ecb0ed6',
     x86_64: 'aea1ea8fdc7d53166a36e983bf092e0a41cb8b7a9133548bc88a964d5219f3bf'
  })

  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'fribidi' # Gets built inside install automatically.
  depends_on 'glib'
  depends_on 'gobject_introspection' # add this package to build gtk+, avoid compilation error
  depends_on 'harfbuzz'
  depends_on 'libx11'
  depends_on 'libxdmcp'
  depends_on 'libxft'
  depends_on 'libxrender'
  depends_on 'py3_six'
  depends_on 'xorg_proto' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dinstall-tests=false \
    -Dcairo=enabled \
    -Dfreetype=enabled \
    -Dfontconfig=enabled \
    -Dlibthai=disabled \
    -Dgtk_doc=false builddir"
    # gtk-doc is set to false because I (@saltedcofii) am not
    # convinced anyone is reading them; it's accessable online anyway
    system 'meson configure builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    system 'samu -C builddir test || true'
  end
end
