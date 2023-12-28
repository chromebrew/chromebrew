require 'buildsystems/cmake'

class Qbittorrent < CMake
  description 'Open-source software alternative to µTorrent.'
  homepage 'https://www.qbittorrent.org/'
  version '4.6.2'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://downloads.sourceforge.net/project/qbittorrent/qbittorrent/qbittorrent-4.6.2/qbittorrent-4.6.2.tar.xz'
  source_sha256 'e96bf2e49d5bf1a9970315af4e61ebc8e61d3f17e0ff1013d11881dbf4c233a0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.6.2_armv7l/qbittorrent-4.6.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.6.2_armv7l/qbittorrent-4.6.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.6.2_x86_64/qbittorrent-4.6.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6e3f08c2a7e023041462691a92f48f6a4d60e9878226339ce0884a59489b448b',
     armv7l: '6e3f08c2a7e023041462691a92f48f6a4d60e9878226339ce0884a59489b448b',
     x86_64: '43a4d1512c62d2f5321873de610b7cd822b418586cf3f9ea1e3a33f441c5e613'
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
