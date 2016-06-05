require 'package'

class Pcre < Package
  version '8.36'

  binary_url ({
    x86_64: 'https://dl.bintray.com/brunux/chromebrew/pcre-8.36-chromebrew.tar.gz'
  })
  binary_sha1 ({
    x86_64: '99bfc62976ea7ed24a605160c8bde1f64158c1ca'
  })

  source_url 'https://dl.bintray.com/brunux/chromebrew/pcre-8.36-src.tar.gz' 
  source_sha1 'fb537757756818133d8157ec878bc11f5a93ef4d'

  depends_on 'buildessential'
  depends_on 'make'
  depends_on 'binutils'
  depends_on 'diffutils'
  depends_on 'glibc'
  depends_on 'gawk'
  depends_on 'gcc'
  depends_on 'pkgconfig'
  depends_on 'readline'

  def self.build  
    system "./configure --prefix=/usr/local/ --docdir=/usr/local/share/doc/pcre-8.36 --enable-unicode-properties --enable-pcre16 --enable-pcre32 --enable-pcregrep-libz --enable-pcregrep-libbz2 
--enable-pcretest-libreadline --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
