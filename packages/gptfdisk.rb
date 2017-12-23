require 'package'

class Gptfdisk < Package
  description 'GPT fdisk is a disk partitioning tool loosely modeled on Linux fdisk, but used for modifying GUID Partition Table (GPT) disks.'
  homepage 'https://sourceforge.net/projects/gptfdisk/'
  version '1.0.3-1'
  source_url 'https://sourceforge.net/projects/gptfdisk/files/gptfdisk/1.0.3/gptfdisk-1.0.3.tar.gz'
  source_sha256 '89fd5aec35c409d610a36cb49c65b442058565ed84042f767bba614b8fc91b5c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gptfdisk-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gptfdisk-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gptfdisk-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gptfdisk-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '37fe533d7e6a63eff2421ad476ba5d396df6ac804e9edf206f9a50fbfe916fec',
     armv7l: '37fe533d7e6a63eff2421ad476ba5d396df6ac804e9edf206f9a50fbfe916fec',
       i686: 'c74ffde53936326f8583384c3c155475f0aa79a5c1c469924f22b2f9780d1b03',
     x86_64: 'eeed31e68f4d3e186a6fc6046bb91cd06bc245b81472dc009a1f1b4ccf0d8562',
  })

  depends_on 'libuuid'
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
