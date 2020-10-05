require 'package'

class Openssh < Package
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '8.4'
  compatibility 'all'
  source_url 'https://github.com/openssh/openssh-portable/archive/V_8_4_P1.tar.gz'
  source_sha256 'b924181983a77cb10e61530960e818ccae075e5c457ea6b9f67e4946009563db'


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
