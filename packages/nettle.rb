require 'package'

class Nettle < Package
  description 'Nettle is a cryptographic library that is designed to fit easily in more or less any context: In crypto toolkits for object-oriented languages (C++, Python, Pike, ...), in applications like LSH or GNUPG, or even in kernel space.'
  homepage 'http://www.lysator.liu.se/~nisse/nettle/'
  version '3.3'
  source_url 'https://ftp.gnu.org/gnu/nettle/nettle-3.3.tar.gz'
  source_sha256 '46942627d5d0ca11720fec18d81fc38f7ef837ea4197c1f630e71ce0d470b11e'

  depends_on 'buildessential'
  depends_on 'm4'
  depends_on 'openssl'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
