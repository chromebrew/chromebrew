require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  @_ver = '1.49.1'
  version "#{@_ver}-1"
  license 'LGPL-2+ and FTL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.49.1-1_armv7l/pango-1.49.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.49.1-1_armv7l/pango-1.49.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.49.1-1_i686/pango-1.49.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.49.1-1_x86_64/pango-1.49.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5ac0e10a9a277da0c66477d153787f491ffc5c6a7c7fb8fd7329f939ab4601f2',
     armv7l: '5ac0e10a9a277da0c66477d153787f491ffc5c6a7c7fb8fd7329f939ab4601f2',
       i686: '5017a2dd7da73298ea89400e8be15d546e4cb5aa07f2bc253cd1aadfa762b1e1',
     x86_64: '99a850bbfbac333ae89ec458a4a65109c341d3953e233149a25db960c2e27de5'
  })

  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'fribidi' # Gets built inside install automatically.
  depends_on 'glib'
  depends_on 'gobject_introspection' # add this package to build gtk+, avoid compilation error
  depends_on 'harfbuzz'
  depends_on 'libx11'
  depends_on 'libxft'
  depends_on 'libxrender'
  depends_on 'py3_six'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dinstall-tests=false \
    -Dcairo=enabled \
    -Dfreetype=enabled \
    -Dfontconfig=enabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
