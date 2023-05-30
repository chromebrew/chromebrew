require 'package'

class Libtorrent < Package
  description 'Feature complete C++ bittorrent implementation focusing on efficiency and scalability.'
  homepage 'https://www.libtorrent.org/'
  version '2.0.9'
  license 'Unknown, BSD-3-Clause'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/arvidn/libtorrent/releases/download/v2.0.9/libtorrent-rasterbar-2.0.9.tar.gz'
  source_sha256 '90cd92b6061c5b664840c3d5e151d43fedb24f5b2b24e14425ffbb884ef1798e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtorrent/2.0.9_armv7l/libtorrent-2.0.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtorrent/2.0.9_armv7l/libtorrent-2.0.9-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtorrent/2.0.9_x86_64/libtorrent-2.0.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2f5e89080e1a33b85c2d0251bce32f5fed15e575e1d9c31ab4443bb25d297864',
     armv7l: '2f5e89080e1a33b85c2d0251bce32f5fed15e575e1d9c31ab4443bb25d297864',
     x86_64: '3645ec9a0eb50e1c11f046206a372e9973264f64acd35d8a2d4c711804757b1e'
  })

  depends_on 'cmake' => :build
  depends_on 'boost'

  def self.build
    system "cmake -B builddir #{CREW_CMAKE_OPTIONS} -G Ninja"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
