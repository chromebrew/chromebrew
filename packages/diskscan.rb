require 'package'

class Diskscan < Package
  description 'diskscan is intended to find sectors of a storage medium (hard disk, flash drive or pendrive, etc.) which are bad or in the process of going bad.'
  homepage 'http://blog.disksurvey.org/proj/diskscan/'
  version '0.19-1'
  source_url 'https://github.com/baruch/diskscan/archive/0.19.tar.gz'
  source_sha256 '92a7298af99043e1e584e4343040b6574b9229f44c122e1cbcb90ba478d928d1'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/diskscan-0.19-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/diskscan-0.19-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/diskscan-0.19-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/diskscan-0.19-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f9935c4832761838472c265106acdfd05ddf40106c662d1cdbca3b41f6ab1e0d',
     armv7l: 'f9935c4832761838472c265106acdfd05ddf40106c662d1cdbca3b41f6ab1e0d',
       i686: '4f946ad0e0fd9d9420b373ce72f77abfa876dabfc2620c1552bfdadc8cb4229a',
     x86_64: '069edbf22cfeccacd021a8c343e3eb508967ca7490399cc1cde790ff61bdf0d2',
  })

  depends_on 'cmake' => :build
  depends_on 'termcap'

  def self.build
    system "cmake ."
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
