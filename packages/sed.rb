require 'package'

class Sed < Package
  description 'sed (stream editor) is a non-interactive command-line text editor.'
  homepage 'https://www.gnu.org/software/sed/'
  version '4.1.5'
  source_url 'https://ftpmirror.gnu.org/sed/sed-4.1.5.tar.gz'
  source_sha256 'be955bef7a81d69222e929689e0de0ecf64c13dc5b15b2ee5696d5ef66fdeec0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '70e097dc6cc82ddb5b840aa57a6495d8a48788e2b9ff72ff866d9addcddb91bb',
     armv7l: '70e097dc6cc82ddb5b840aa57a6495d8a48788e2b9ff72ff866d9addcddb91bb',
       i686: '56cc17109f324dbb5a0a2eecef1049edb5c1b703168ae94bf05a41bfe8fb10ae',
     x86_64: 'b5dae5c90e468223d92e97e40cb4fbd827bf3af5e9aad3812afa85419efa475d',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "sed -i 's, po , ,g' Makefile"
    system "sed -i 's,sed -e,sed,g' Makefile"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
