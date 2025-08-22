require 'buildsystems/cmake'

class Qbittorrent < CMake
  description 'Open-source software alternative to µTorrent.'
  homepage 'https://www.qbittorrent.org/'
  version '5.1.2'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.37'
  source_url "https://downloads.sourceforge.net/project/qbittorrent/qbittorrent/qbittorrent-#{version}/qbittorrent-#{version}.tar.xz"
  source_sha256 'd5806092c71959a5dbdf55c645ea45ed48a70369ab6c226039b83f1ade6979f2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ab18023baf9d990fb90acabc39884c9b0f38ef008e9ecef20cd9d90dea9619b6',
     armv7l: 'ab18023baf9d990fb90acabc39884c9b0f38ef008e9ecef20cd9d90dea9619b6',
     x86_64: 'dbaca4cd1e372ac6707b8d9547bf571d401067c1c151ca55f8cb9bb61f0824f0'
  })

  depends_on 'cmake' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libtorrent' # R
  depends_on 'openssl' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_svg' => :build
  depends_on 'qt5_tools' => :build
  depends_on 'zlib' # R
end
