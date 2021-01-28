require 'package'

class Wpebackend_fdo < Package
  description 'Freedesktop.org backend for WPE WebKit'
  homepage 'https://wpewebkit.org'
  @_ver = '1.8.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/Igalia/WPEBackend-fdo/releases/download/#{@_ver}/wpebackend-fdo-#{@_ver}.tar.xz"
  source_sha256 '9652a99c75fe1c6eab0585b6395f4e104b2427e4d1f42969f1f77df29920d253'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wpebackend_fdo-1.8.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wpebackend_fdo-1.8.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/wpebackend_fdo-1.8.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wpebackend_fdo-1.8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '2eb8dbb4be7ec82b3b48c5396759f447374b206ef3d498d49899a86b066b60d0',
      armv7l: '2eb8dbb4be7ec82b3b48c5396759f447374b206ef3d498d49899a86b066b60d0',
        i686: '77e5834339fe892f5f4eca9f642b28a5e7f72e5c1ecaafff8b5acea570543e90',
      x86_64: 'a6ebf24575dc975a1615508cd259542ea3379529dae274ae800e64b5166cf5f6',
  })

  depends_on 'libwpe'
  depends_on 'wayland'
  depends_on 'libepoxy'
  depends_on 'mesa' => ':build'
  depends_on 'wayland_protocols' => ':build'

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
