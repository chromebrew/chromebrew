require 'package'

class Rfkill < Package
  description 'Tool for enabling and disabling wireless devices.'
  homepage 'http://linuxwireless.org/en/users/Documentation/rfkill'
  version '0.5'
  compatibility 'all'
  source_url 'https://www.kernel.org/pub/software/network/rfkill/rfkill-0.5.tar.xz'
  source_sha256 'e0ae3004215e39a6c5c36e0726558740728d16f67ebdb8bea621250f6091d86a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rfkill-0.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rfkill-0.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rfkill-0.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rfkill-0.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '23aa25afb00546a728082d06d0b1e4f55a98c684d1bc43003f935efb661dced6',
     armv7l: '23aa25afb00546a728082d06d0b1e4f55a98c684d1bc43003f935efb661dced6',
       i686: '38e7c40f7206437a02e33a7219f08d1c47578bb254be0959dc7abbaf073ca1a3',
     x86_64: 'b491bd154ece2066272972c2110f8bc5d6c9a3ce4a0189fda5825d3cbddb0d71',
  })

  depends_on 'buildessential' => :build

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "SBINDIR=#{CREW_PREFIX}/sbin", "MANDIR=#{CREW_PREFIX}/share/man", "install"
  end

  def self.check
    system "make check"
  end
end
