require 'package'

class Pcre2 < Package
  description 'The PCRE2 package contains a new generation of the Perl Compatible Regular Expression libraries.'
  homepage 'http://pcre.org/'
  version '10.34'
  source_url 'https://ftp.pcre.org/pub/pcre/pcre2-10.34.tar.gz'
  source_sha256 'da6aba7ba2509e918e41f4f744a59fa41a2425c59a298a232e7fe85691e00379'

  binary_url ({
  })
  binary_sha256 ({
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
