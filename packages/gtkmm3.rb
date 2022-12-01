require 'package'

class Gtkmm3 < Package
  description 'The Gtkmm3 package provides a C++ interface to GTK+ 3.'
  homepage 'https://www.gtkmm.org/'
  version '3.24.4'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gtkmm/3.24/gtkmm-3.24.4.tar.xz'
  source_sha256 '9beb71c3e90cfcfb790396b51e3f5e7169966751efd4f3ef9697114be3be6743'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtkmm3/3.24.4_armv7l/gtkmm3-3.24.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtkmm3/3.24.4_armv7l/gtkmm3-3.24.4-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtkmm3/3.24.4_i686/gtkmm3-3.24.4-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtkmm3/3.24.4_x86_64/gtkmm3-3.24.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'df6763cd6810ef3b578f97525e5455dcf1dc37a2eeca0a282412dc269f75446e',
     armv7l: 'df6763cd6810ef3b578f97525e5455dcf1dc37a2eeca0a282412dc269f75446e',
       i686: '57287908562c48a645942a700fe9fc81a9fec23a9c5ee2c03b25c1d28b73be6d',
     x86_64: '9c6c186cf88f779ee435f6995d3c583278d267e381e00d1f2f5013397f703390'
  })

  depends_on 'atkmm'
  depends_on 'gtk3'
  depends_on 'pangomm'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    --default-library=both \
    -Dbuild-documentation=false \
    -Dbuild-demos=false \
    -Dbuild-tests=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
