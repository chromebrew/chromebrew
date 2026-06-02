require 'package'

class Gptfdisk < Package
  description 'GPT fdisk is a disk partitioning tool loosely modeled on Linux fdisk, but used for modifying GUID Partition Table (GPT) disks.'
  homepage 'https://sourceforge.net/projects/gptfdisk/'
  version '1.0.10'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://sourceforge.net/projects/gptfdisk/files/gptfdisk/#{version}/gptfdisk-#{version}.tar.gz"
  source_sha256 '2abed61bc6d2b9ec498973c0440b8b804b7a72d7144069b5a9209b2ad693a282'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a061994a24c5f97f6633828ca6a3ebe9a9e263502023a716c0c1e0b704b28aea',
     armv7l: 'a061994a24c5f97f6633828ca6a3ebe9a9e263502023a716c0c1e0b704b28aea',
       i686: '5b01459588cc91a4baab210b70c25bd93fc9c2be5a1bcaf059eaa2b211b07743',
     x86_64: 'd24b31bd6a290c9eb293ae913aeb2cc281bcb1e27f67da4f1076d41bc39a71bb'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'popt' => :executable
  depends_on 'util_linux' => :executable

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw make"
  end

  def self.install
    FileUtils.install Dir['*gdisk'], "#{CREW_DEST_PREFIX}/bin/", mode: 0o755
    FileUtils.install 'fixparts', "#{CREW_DEST_PREFIX}/bin/fixparts", mode: 0o755
    FileUtils.install Dir['*.8'], "#{CREW_DEST_MAN_PREFIX}/man8/", mode: 0o644
  end
end
