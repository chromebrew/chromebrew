require 'buildsystems/cmake'

class Qbittorrent < CMake
  description 'Open-source software alternative to µTorrent.'
  homepage 'https://www.qbittorrent.org/'
  version '4.6.6'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.37'
  source_url 'https://downloads.sourceforge.net/project/qbittorrent/qbittorrent/qbittorrent-4.6.6/qbittorrent-4.6.6.tar.xz'
  source_sha256 '5f9f3e0b89861e8bae1894656f8b8f76feddb3c92e228065c8173632af6e544e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4c30e5dab2abdba5be6e33bc1f42b9425438c9d68d02b95abba9ff65abc93da2',
     armv7l: '4c30e5dab2abdba5be6e33bc1f42b9425438c9d68d02b95abba9ff65abc93da2',
     x86_64: 'edc558f1067f4bfa2c4fb28fa495a1c7f3227144b3d989488f1b993a16512df8'
  })

  depends_on 'cmake' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libtorrent' # R
  depends_on 'openssl' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_svg' => :build
  depends_on 'qt5_tools' => :build
  depends_on 'zlib' # R
end
