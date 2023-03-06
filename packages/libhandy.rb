require 'package'

class Libhandy < Package
  description 'The aim of the handy library is to help with developing UI for mobile devices using GTK/GNOME.'
  homepage 'https://gitlab.gnome.org/GNOME/libhandy/'
  @_ver = '1.8.0'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libhandy.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libhandy/1.8.0_armv7l/libhandy-1.8.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libhandy/1.8.0_armv7l/libhandy-1.8.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libhandy/1.8.0_i686/libhandy-1.8.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libhandy/1.8.0_x86_64/libhandy-1.8.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '570f7011b52c4599c7cf7021d8aff15b0a93621d381030d5e04640498239565e',
     armv7l: '570f7011b52c4599c7cf7021d8aff15b0a93621d381030d5e04640498239565e',
       i686: '5a12c0b53e78054068d93d68428106ba0d15a2b9a93ee411d2cb666cffeabffb',
     x86_64: '5bb6704da3f64fb2a1259fc79dae2680804d007316c552c23a8eefb506ca53f2'
  })

  depends_on 'at_spi2_core'
  depends_on 'cairo'
  depends_on 'fribidi'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'libjpeg'
  depends_on 'pango'
  depends_on 'vala'
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
