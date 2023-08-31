require 'buildsystems/cmake'

class Qbittorrent < CMake
  description 'Open-source software alternative to µTorrent.'
  homepage 'https://www.qbittorrent.org/'
  version '4.5.5'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://downloads.sourceforge.net/project/qbittorrent/qbittorrent/qbittorrent-4.5.5/qbittorrent-4.5.5.tar.xz'
  source_sha256 '8e84a5ba63c7203cfb2e5bb23e27d000120fb8e9dfb6e9f9a1064dce1b9294e9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.5.5_armv7l/qbittorrent-4.5.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.5.5_armv7l/qbittorrent-4.5.5-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.5.5_x86_64/qbittorrent-4.5.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9045a454ba60dc4fa804baddad9565b42aafb0a72fafec49dd449a30cd6f3b75',
     armv7l: '9045a454ba60dc4fa804baddad9565b42aafb0a72fafec49dd449a30cd6f3b75',
     x86_64: '379f2d6c721583b758ca88b7faf48cd06cd5cd43efc0b422acaa2ccedb39e32f'
  })

  depends_on 'cmake' => :build
  depends_on 'qtbase'
  depends_on 'qttools' => :build
  depends_on 'qtsvg'
  depends_on 'libtorrent'
end
