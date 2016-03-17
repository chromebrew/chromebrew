require 'package'

class Openssl < Package
  version '1.0.2g'
  source_url 'https://ftp.openssl.org/source/openssl-1.0.2g.tar.gz'
  source_sha1 '36af23887402a5ea4ebef91df8e61654906f58f2'

  def self.build
    system "./config shared"
    system "CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\" make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "ln -sf /usr/local/ssl/openssl/includes /usr/local/include/openssl"
    system "ln -sf /usr/local/ssl/bin/openssl /usr/local/bin/openssl"
  end
end
