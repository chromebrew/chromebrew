require 'buildsystems/cmake'

class Qbittorrent < CMake
  description 'Open-source software alternative to µTorrent.'
  homepage 'https://www.qbittorrent.org/'
  version '4.6.3'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://downloads.sourceforge.net/project/qbittorrent/qbittorrent/qbittorrent-4.6.3/qbittorrent-4.6.3.tar.xz'
  source_sha256 '5f9f3e0b89861e8bae1894656f8b8f76feddb3c92e228065c8173632af6e544e'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.6.3_armv7l/qbittorrent-4.6.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.6.3_armv7l/qbittorrent-4.6.3-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.6.3_x86_64/qbittorrent-4.6.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a3bb615c33f412adcf44b9284b5f9c28c45d2f05dab0d299220b28d4844d64ff',
     armv7l: 'a3bb615c33f412adcf44b9284b5f9c28c45d2f05dab0d299220b28d4844d64ff',
     x86_64: 'afbe852b182f0e0ca7abc58a16415da49f1ae294853436b2b5e14d50c3b8cc54'
  })

  depends_on 'cmake' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libtorrent' # R
  depends_on 'openssl' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_svg' => :build
  depends_on 'qt5_tools' => :build
  depends_on 'zlibpkg' # R
end
