require 'package'

class Qbittorrent < Package
  description 'Open-source software alternative to µTorrent.'
  homepage 'https://www.qbittorrent.org/'
  version '4.5.4'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://downloads.sourceforge.net/project/qbittorrent/qbittorrent/qbittorrent-4.5.4/qbittorrent-4.5.4.tar.xz'
  source_sha256 'f92bcd3ed25600796c59257c507e56a252a65af60bd042b71f1e7ff3fe5264da'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.5.4_armv7l/qbittorrent-4.5.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.5.4_armv7l/qbittorrent-4.5.4-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.5.4_x86_64/qbittorrent-4.5.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0c2bd9443fadff4a1a9695e3d47040d32fc06c3661b5517cac6db5a14ba4875f',
     armv7l: '0c2bd9443fadff4a1a9695e3d47040d32fc06c3661b5517cac6db5a14ba4875f',
     x86_64: '788824323beda84bb552fc02b246b81e32ac3d8aa6ea6b78fe0e303ae5e2dfce'
  })

  depends_on 'cmake' => :build
  depends_on 'qtbase'
  depends_on 'qttools' => :build
  depends_on 'qtsvg'
  depends_on 'libtorrent'

  def self.build
    system "cmake -B builddir #{CREW_CMAKE_OPTIONS} -G Ninja"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
