require 'package'

class Gptfdisk < Package
  description 'GPT fdisk is a disk partitioning tool loosely modeled on Linux fdisk, but used for modifying GUID Partition Table (GPT) disks.'
  homepage 'https://sourceforge.net/projects/gptfdisk/'
  version '1.0.3'
  source_url 'https://sourceforge.net/projects/gptfdisk/files/gptfdisk/1.0.3/gptfdisk-1.0.3.tar.gz'
  source_sha256 '89fd5aec35c409d610a36cb49c65b442058565ed84042f767bba614b8fc91b5c'

  binary_url ({
  })
  binary_sha256 ({
  })

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
