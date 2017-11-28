require 'package'

class Nettle < Package
  description 'Nettle is a cryptographic library that is designed to fit easily in more or less any context: In crypto toolkits for object-oriented languages (C++, Python, Pike, ...), in applications like LSH or GNUPG, or even in kernel space.'
  homepage 'http://www.lysator.liu.se/~nisse/nettle/'
  version '3.4'
  source_url 'https://ftp.gnu.org/gnu/nettle/nettle-3.4.tar.gz'
  source_sha256 'ae7a42df026550b85daca8389b6a60ba6313b0567f374392e54918588a411e94'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'm4'
  depends_on 'openssl'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
