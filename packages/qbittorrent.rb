require 'package'

class Qbittorrent < Package
  description 'Open-source software alternative to µTorrent.'
  homepage 'https://www.qbittorrent.org/'
  version '4.5.3'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://downloads.sourceforge.net/project/qbittorrent/qbittorrent/qbittorrent-4.5.3/qbittorrent-4.5.3.tar.xz'
  source_sha256 '017253c83ed0cd7893d6b5fb4a669790502226afc27df14e0ecdfdba3568d60a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.5.3_armv7l/qbittorrent-4.5.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.5.3_armv7l/qbittorrent-4.5.3-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qbittorrent/4.5.3_x86_64/qbittorrent-4.5.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0b4e50e72927dbf7511f23104c2dc6b6deaa5aa7e1bbf3cf87d28e8fa6ef1e66',
     armv7l: '0b4e50e72927dbf7511f23104c2dc6b6deaa5aa7e1bbf3cf87d28e8fa6ef1e66',
     x86_64: 'a2c023d33b08d62946be072b81e4f2e6383dd55bfa96d55c36fbbf11ceb42e7d'
  })

  depends_on 'cmake' => :build
  depends_on 'qtbase' => :build
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
