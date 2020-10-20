require 'package'

class Pcre2 < Package
  description 'The PCRE2 package contains a new generation of the Perl Compatible Regular Expression libraries.'
  homepage 'http://pcre.org/'
  version '10.35'
  compatibility 'all'
  source_url 'https://ftp.pcre.org/pub/pcre/pcre2-10.35.tar.gz'
  source_sha256 '8fdcef8c8f4cd735169dd0225fd010487970c1bcadd49e9b90e26c7250a33dc9'


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
