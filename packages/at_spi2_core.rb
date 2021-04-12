require 'package'

class At_spi2_core < Package
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'http://www.freedesktop.org/'
  version '2.39.91'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://download.gnome.org/core/40/40.rc/sources/at-spi2-core-2.39.91.tar.xz'
  source_sha256 '4f71d3d208736adfe004102b4caca0ad70a7e3986d9bcd1661d7d824e10bbfb3'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_core-2.39.91-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_core-2.39.91-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_core-2.39.91-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_core-2.39.91-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7a9ab15123727d6036c8b30b9a35ab52f71745a8a4edce0fe80039216c2649b1',
     armv7l: '7a9ab15123727d6036c8b30b9a35ab52f71745a8a4edce0fe80039216c2649b1',
       i686: 'd29109b831f23f0412f79c174fcd0b0c13e69ffdccd86d2bf7663601a4252fd6',
     x86_64: '7ae8a3cca653f06dc1efb1945117bd0fbab719462b3bdbc385057664f25acfc2'
  })

  depends_on 'libxtst'
  depends_on 'dbus'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'libxcb'
  depends_on 'gtk_doc'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
