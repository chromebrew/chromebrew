require 'package'

class Openssh < Package
  version '7.2p1'
  source_url 'http://mirror.internode.on.net/pub/OpenBSD/OpenSSH/portable/openssh-7.2p1.tar.gz'
  source_sha1 'd30a6fd472199ab5838a7668c0c5fd885fb8d371'

  def self.build
    system "./configure --libdir=/usr/local/lib#{SHORTARCH}/ CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
