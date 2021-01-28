require 'package'

class Libwpe < Package
  description 'General-purpose library for WPE WebKit'
  homepage 'https://wpewebkit.org'
  @_ver = '1.8.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/WebPlatformForEmbedded/libwpe/releases/download/#{@_ver}/libwpe-#{@_ver}.tar.xz"
  source_sha256 'a6f00a7d091cbd4db57fe7ee3b4c12c6350921d654ed79812800a26c888481d2'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwpe-1.8.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwpe-1.8.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwpe-1.8.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwpe-1.8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '2ac2dfad4b4ada47f50eb01de8e4f48629de8f4d88a7808173c0164f8cfc7978',
      armv7l: '2ac2dfad4b4ada47f50eb01de8e4f48629de8f4d88a7808173c0164f8cfc7978',
        i686: 'c6ea7fb4281d48faf071f6a701e372863046ebfca86d3c9bb644f405e2192bf7',
      x86_64: 'fb76a33b0eaed0ebb0ed586ee019a12d6f5a77e2b3b1e99ccc3ecd9884e43b20',
  })

  depends_on 'libxkbcommon'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
