require 'package'

class Gptfdisk < Package
  description 'GPT fdisk is a disk partitioning tool loosely modeled on Linux fdisk, but used for modifying GUID Partition Table (GPT) disks.'
  homepage 'https://sourceforge.net/projects/gptfdisk/'
  version '1.0.3-1'
  source_url 'https://sourceforge.net/projects/gptfdisk/files/gptfdisk/1.0.3/gptfdisk-1.0.3.tar.gz'
  source_sha256 '89fd5aec35c409d610a36cb49c65b442058565ed84042f767bba614b8fc91b5c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gptfdisk-1.0.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gptfdisk-1.0.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gptfdisk-1.0.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gptfdisk-1.0.3-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'afd7cdcf168c6d6097ea341b30fb52d62b2a007cf086d42cb8515f267b66784a',
     armv7l: 'afd7cdcf168c6d6097ea341b30fb52d62b2a007cf086d42cb8515f267b66784a',
       i686: 'e5af90a92886b5f9e7236345940ec9bb365332f105d65b2678153bca33b5ba46',
     x86_64: 'eb8dd86aff1b9610681d764eef74351ed687ed307c519ef646ae2c8448017946',
  })

  depends_on 'util_linux'
  depends_on 'ncurses'
  depends_on 'popt'

  def self.build
    system "sed -i 's,<ncurses.h>,<#{CREW_PREFIX}/include/ncurses/ncurses.h>,g' gptcurses.cc"
    system "sed -i 's,<popt.h>,<#{CREW_PREFIX}/include/popt.h>,g' gptcurses.cc"
    system "make"
  end

  def self.install
    system "install -Dm755 cgdisk #{CREW_DEST_PREFIX}/bin/cgdisk"
    system "install -Dm755 fixparts #{CREW_DEST_PREFIX}/bin/fixparts"
    system "install -Dm755 gdisk #{CREW_DEST_PREFIX}/bin/gdisk"
    system "install -Dm755 sgdisk #{CREW_DEST_PREFIX}/bin/sgdisk"
    system "gzip -9 cgdisk.8 fixparts.8 gdisk.8 sgdisk.8"
    system "install -Dm644 cgdisk.8.gz #{CREW_DEST_PREFIX}/share/man/man8/cgdisk.8.gz"
    system "install -Dm644 fixparts.8.gz #{CREW_DEST_PREFIX}/share/man/man8/fixparts.8.gz"
    system "install -Dm644 gdisk.8.gz #{CREW_DEST_PREFIX}/share/man/man8/gdisk.8.gz"
    system "install -Dm644 sgdisk.8.gz #{CREW_DEST_PREFIX}/share/man/man8/sgdisk.8.gz"
  end
end
