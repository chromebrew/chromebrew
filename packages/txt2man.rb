require 'package'

class Txt2man < Package
  description 'Txt2man converts flat ASCII text to man page format.'
  homepage 'http://mvertes.free.fr/'
  version '1.5.6-1'
  compatibility 'all'
  source_url 'http://mvertes.free.fr/download/txt2man-1.5.6.tar.gz'
  source_sha256 '984825c5fd0cb3495160bf3277f327078081a8dc219dc466509e307ec9a2b52a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/txt2man-1.5.6-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/txt2man-1.5.6-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/txt2man-1.5.6-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/txt2man-1.5.6-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0b6b3292d3f543f885b9aa8bfa91e0ffc25c539e73f412604077855bc2c8f5d7',
     armv7l: '0b6b3292d3f543f885b9aa8bfa91e0ffc25c539e73f412604077855bc2c8f5d7',
       i686: '188870876c03bdd218e4a7bbd542dd5006d961a2bd8640714a8981b8d89d2532',
     x86_64: 'e0776d50fcdc817d6646b9424029ab244bcfcfaa4a16c209bfb7b29bb5e14dab',
  })

  def self.build
    system "gzip -9 *.1"
  end

  def self.install
    system "install -Dm755 bookman #{CREW_DEST_PREFIX}/bin/bookman"
    system "install -Dm755 src2man #{CREW_DEST_PREFIX}/bin/src2man"
    system "install -Dm755 txt2man #{CREW_DEST_PREFIX}/bin/txt2man"
    system "install -Dm644 bookman.1.gz #{CREW_DEST_PREFIX}/man/man1/bookman.1.gz"
    system "install -Dm644 src2man.1.gz #{CREW_DEST_PREFIX}/man/man1/src2man.1.gz"
    system "install -Dm644 txt2man.1.gz #{CREW_DEST_PREFIX}/man/man1/txt2man.1.gz"
  end
end
