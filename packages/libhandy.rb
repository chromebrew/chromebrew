require 'package'

class Libhandy < Package
  description 'The aim of the handy library is to help with developing UI for mobile devices using GTK/GNOME.'
  homepage 'https://gitlab.gnome.org/GNOME/libhandy/'
  @_ver = '1.4.0'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libhandy.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libhandy/1.4.0_armv7l/libhandy-1.4.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libhandy/1.4.0_armv7l/libhandy-1.4.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libhandy/1.4.0_x86_64/libhandy-1.4.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '518a1687d6bfb8497e19a50f2a64810dc7e466ffc03bd29a63c93a2039730dc7',
     armv7l: '518a1687d6bfb8497e19a50f2a64810dc7e466ffc03bd29a63c93a2039730dc7',
     x86_64: '4d4ac622317b61751eff09e267e05b7998a2d5ca210b95126b3a82ab7a388caa'
  })

  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'fribidi'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'libjpeg'
  depends_on 'pango'
  depends_on 'vala'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
