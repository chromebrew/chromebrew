require 'package'

class Pcre2 < Package
  description 'The PCRE2 package contains a new generation of the Perl Compatible Regular Expression libraries.'
  homepage 'http://pcre.org'
  version '10.31'
  source_url 'https://ftp.pcre.org/pub/pcre/pcre2-10.31.tar.gz'
  source_sha256 'e11ebd99dd23a7bccc9127d95d9978101b5f3cf0a6e7d25a1b1ca165a97166c4'

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
