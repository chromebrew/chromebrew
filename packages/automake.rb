require 'package'

class Automake < Package
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'http://www.gnu.org/software/automake/'
  version '1.16.1'
  source_url 'https://ftpmirror.gnu.org/automake/automake-1.16.1.tar.xz'
  source_sha256 '5d05bb38a23fd3312b10aea93840feec685bdf4a41146e78882848165d3ae921'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/automake-1.16.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/automake-1.16.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/automake-1.16.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/automake-1.16.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '83961e48a99575d70e225d4d0b89b71eae90dd7308fb6a5e8234831afdb87134',
     armv7l: '83961e48a99575d70e225d4d0b89b71eae90dd7308fb6a5e8234831afdb87134',
       i686: '46cc913feaf2b7ad6490967361fc36ee69181deb0481c9287d9949fcfe45b579',
     x86_64: '3f9ff866f29e8b15b99e2b807e2c7f75d8091d551f25ab5480b60703c3612ba6',
  })

  depends_on 'autoconf'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
