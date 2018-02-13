require 'package'

class Pcre2 < Package
  description 'The PCRE2 package contains a new generation of the Perl Compatible Regular Expression libraries.'
  homepage 'http://pcre.org/'
  version '10.30'
  source_url 'https://ftp.pcre.org/pub/pcre/pcre2-10.30.tar.gz'
  source_sha256 'b549873a39f804480c2e6145a78adcba53e38162d90ef6ea92384f6ecf2fde76'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.30-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.30-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.30-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.30-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b36916b0648275dfadc42cec5c3b56210105b0f44dd07b49330f83507d3e2e2e',
     armv7l: 'b36916b0648275dfadc42cec5c3b56210105b0f44dd07b49330f83507d3e2e2e',
       i686: '3a6731ebebf1339f48f546f05de9cc1c9abfea9789d6a2a3bcabde3acbccc897',
     x86_64: '3994cf0a26a2c3904851bdcb071f9348d59d57e78763459a8cea9fc4b88327b2',
  })

  depends_on 'libtool' => :build

  def self.build
    system "./configure \
           --prefix=#{CREW_PREFIX} \
           --libdir=#{CREW_LIB_PREFIX} \
           --enable-pcre2-16 \
           --enable-pcre2-32 \
           --enable-unicode \
           --enable-pcre2-16 \
           --enable-pcre2-32 \
           --enable-pcre2test-libreadline \
           --enable-jit \
           --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
