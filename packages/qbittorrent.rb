require 'buildsystems/cmake'

class Qbittorrent < CMake
  description 'Open-source software alternative to µTorrent.'
  homepage 'https://www.qbittorrent.org/'
  version '4.6.0'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://downloads.sourceforge.net/project/qbittorrent/qbittorrent/qbittorrent-4.6.0/qbittorrent-4.6.0.tar.xz'
  source_sha256 '27a5954dccd3948dc69dd59d24ee8f4f7427bdc09359fb30cf05c786b370d3be'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.6.0_armv7l/qbittorrent-4.6.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.6.0_armv7l/qbittorrent-4.6.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.6.0_x86_64/qbittorrent-4.6.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bcfcab1d82ce71eadd51d6f15a3146fd6d0d95f0a0d2519dcb6609e1fef4f67c',
     armv7l: 'bcfcab1d82ce71eadd51d6f15a3146fd6d0d95f0a0d2519dcb6609e1fef4f67c',
     x86_64: '80bc158761f5beac01aa02f567382a04edaa0cada2fd1e1375fbd9101f702ab8'
  })

  depends_on 'cmake' => :build
  depends_on 'qtbase' => :build
  depends_on 'qttools' => :build
  depends_on 'qtsvg'
  depends_on 'libtorrent'
end
