require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'https://pango.gnome.org/'
  @_ver = '1.50.6'
  version @_ver
  license 'LGPL-2+ and FTL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.6_armv7l/pango-1.50.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.6_armv7l/pango-1.50.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.6_i686/pango-1.50.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.6_x86_64/pango-1.50.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0bfbe4cd5abae49df9607a31fa0bb63beea7fa035de915bc63ede502830fe0ab',
     armv7l: '0bfbe4cd5abae49df9607a31fa0bb63beea7fa035de915bc63ede502830fe0ab',
       i686: '9822afa1329ee5fe532965dc5f381abf6bdaae1c7c3670f36f000a568097beb3',
     x86_64: '23e71f4700068b9123fdcc7fe5d6750602a077c4c7d0d9954c72411050bf6778'
  })


  depends_on 'harfbuzz'
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
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    system 'samu -C builddir test || true'
  end
end
