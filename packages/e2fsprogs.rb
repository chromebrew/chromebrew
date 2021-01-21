require 'package'

class E2fsprogs < Package
  description 'e2fsprogs are ext2/3/4 file system utilities.'
  homepage 'http://e2fsprogs.sourceforge.net/'
  version '1.45.6'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v1.45.6/e2fsprogs-1.45.6.tar.xz'
  source_sha256 'ffa7ae6954395abdc50d0f8605d8be84736465afc53b8938ef473fcf7ff44256'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/e2fsprogs-1.45.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/e2fsprogs-1.45.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/e2fsprogs-1.45.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/e2fsprogs-1.45.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8c2bedd0fb8038b7e79bede2b7042754a6704fcec570433ef77bc9fb6c1b7745',
     armv7l: '8c2bedd0fb8038b7e79bede2b7042754a6704fcec570433ef77bc9fb6c1b7745',
       i686: '78505c168409d8239266de5d24d123b2199453f17255fc1d42b9d59e01539a99',
     x86_64: 'e81555a711b57bed9e3a5a9850f207006ef4c5398d049f07793d314127616965',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
