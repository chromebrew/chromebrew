require 'package'

class Ed < Package
  description 'GNU ed is a line-oriented text editor.'
  homepage 'http://www.gnu.org/software/ed/ed.html'
  version '1.15'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/ed/ed-1.15.tar.lz'
  source_sha256 'ad4489c0ad7a108c514262da28e6c2a426946fb408a3977ef1ed34308bdfd174'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ed-1.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ed-1.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ed-1.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ed-1.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7191a1f8ade2fc029dc0d82783dbcbc2e6176af3cd779756c21e10ca32cd146f',
     armv7l: '7191a1f8ade2fc029dc0d82783dbcbc2e6176af3cd779756c21e10ca32cd146f',
       i686: 'e97ac61ce4cdc2ab518ae2ddd8932500c089e48a8c10f757c456dd2fa7989d3b',
     x86_64: 'b85eb1539017207621a2f6361c760738c1f965889f2691e711a13574f5528925',
  })

  # only lz archive is available for ed and it requires lzip.
  depends_on 'lzip' => :build

  def self.build
    system "./configure",
	   "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
