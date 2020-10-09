require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '8.4'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable/archive/V_8_4_P1.tar.gz'
  source_sha256 'b924181983a77cb10e61530960e818ccae075e5c457ea6b9f67e4946009563db'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openssh-8.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openssh-8.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openssh-8.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openssh-8.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c5b8da68a42483a6e5ffc032a7e699be340169fee6abe956c0b865b7ed617286',
     armv7l: 'c5b8da68a42483a6e5ffc032a7e699be340169fee6abe956c0b865b7ed617286',
       i686: '852034874b0fc63c61eb7db3a770bcf2fbec471153829c61d0f67794d102c5d6',
     x86_64: '38aa21b22cde3bb2d52ee6c3826f92f83326985e58ceae9ef9aa9dcacb7de285',
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
