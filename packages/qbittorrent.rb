require 'buildsystems/cmake'

class Qbittorrent < CMake
  description 'Open-source software alternative to µTorrent.'
  homepage 'https://www.qbittorrent.org/'
  version '4.6.1'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://downloads.sourceforge.net/project/qbittorrent/qbittorrent/qbittorrent-4.6.1/qbittorrent-4.6.1.tar.xz'
  source_sha256 '63223387cab9936a4feae21597b3631f20ba33f33fa73ef3f35d07d63cae3643'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.6.1_armv7l/qbittorrent-4.6.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.6.1_armv7l/qbittorrent-4.6.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.6.1_x86_64/qbittorrent-4.6.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '94b250197ea05707dd327eb023c287a5909ee15e97ec9cb263022be7a86508a5',
     armv7l: '94b250197ea05707dd327eb023c287a5909ee15e97ec9cb263022be7a86508a5',
     x86_64: '5820c1260786d38c765000b5edda7ba593c233b96b9360352cb6e66117b163ff'
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
