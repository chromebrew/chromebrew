require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '8.4-1'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable/archive/V_8_4_P1.tar.gz'
  source_sha256 'b924181983a77cb10e61530960e818ccae075e5c457ea6b9f67e4946009563db'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openssh-8.4-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openssh-8.4-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/openssh-8.4-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openssh-8.4-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '6cc250043f9f5978e65220cc5a499651a292f0d8597eedb97e427ccb80872d29',
      armv7l: '6cc250043f9f5978e65220cc5a499651a292f0d8597eedb97e427ccb80872d29',
        i686: '80b048feee0b23334ffc90fecba4532139ae3f7ccf7bf8bac525a38709f98436',
      x86_64: 'e50c359bf9872cb674f90087654d35d3e2d880d3f869c5ed443b179018de1402',
  })

  depends_on 'autoconf' => :build
  depends_on 'compressdoc' => :build

  def self.build
    system "autoreconf -fiv"
    system "autoheader"
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man5"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man8"
  end
end
