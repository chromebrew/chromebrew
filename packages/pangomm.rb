require 'package'

class Pangomm < Package
  description 'pangomm is the official C++ interface for the Pango font layout library.'
  homepage 'https://developer.gnome.org/pangomm/stable/'
  @_ver = '2.48.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/GNOME/pangomm/archive/#{@_ver}.tar.gz"
  source_sha256 '65130bc4e3662071b4332d1fdae792282764705abf00c0d80a9eb4e8b5886d59'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pangomm-2.48.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pangomm-2.48.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pangomm-2.48.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pangomm-2.48.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f8dbb1e8258270285d3cbdea5e07369f955d663f4233d6afbedaf2a8e26080b7',
     armv7l: 'f8dbb1e8258270285d3cbdea5e07369f955d663f4233d6afbedaf2a8e26080b7',
       i686: '7fd81bfa703ec364ff24b863c98cf5f80c843d0cc35ab247598cb7d515c4758d',
     x86_64: '986d79798b3e7f91c07ee7afac45652b2d157e22d7cf71c3087bd481f674b8a7'
  })

  depends_on 'glibmm'
  depends_on 'cairomm'
  depends_on 'pango'
  depends_on 'graphite'
  depends_on 'mm_common'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dmaintainer-mode=true \
    -Dbuild-documentation=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
