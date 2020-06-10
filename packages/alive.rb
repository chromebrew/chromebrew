require 'package'

class Alive < Package
  description 'Automatic login and keep-alive utility for Internet connections.'
  homepage 'https://www.gnu.org/software/alive/'
  version '2.0.2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/alive/alive-2.0.2.tar.xz'
  source_sha256 '120dd9ef361833623be353ad8cfac585abae51a16fedd3a84f1d99a842793fef'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alive-2.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alive-2.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alive-2.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alive-2.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '02f36ed0016450c778347646a793d743eeb96c5f9cfac3652e53a878eba6a505',
     armv7l: '02f36ed0016450c778347646a793d743eeb96c5f9cfac3652e53a878eba6a505',
       i686: '7b952c08c377e4888ef62bed54c06d051258dfb5b4734033e4a80f8616bae256',
     x86_64: '82bbdaf0fb8e1bcd3763900536caa84dd043ed9296d0e038da7a9f96801716fd',
  })

  depends_on 'guile'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
