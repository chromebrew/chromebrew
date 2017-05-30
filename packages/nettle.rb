require 'package'

class Nettle < Package
  description 'Nettle is a cryptographic library that is designed to fit easily in more or less any context: In crypto toolkits for object-oriented languages (C++, Python, Pike, ...), in applications like LSH or GNUPG, or even in kernel space.'
  homepage 'http://www.lysator.liu.se/~nisse/nettle/'
  version '3.3'
  source_url 'https://ftp.gnu.org/gnu/nettle/nettle-3.3.tar.gz'
  source_sha1 'bf2b4d3a41192ff6177936d7bc3bee4cebeb86c4'

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
