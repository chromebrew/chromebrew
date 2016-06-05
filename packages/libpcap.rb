require 'package'

class Libpcap < Package
  version '1.6.2'

  binary_url ({
    x86_64: 'https://dl.bintray.com/brunux/chromebrew/libpcap-1.6.2-chromebrew.tar.gz'
  })
  binary_sha1 ({
    x86_64: '3474b557119b9f3df745dae9253d5bd18ca220e4'
  })

  source_url 'https://dl.bintray.com/brunux/chromebrew/libpcap-1.6.2-src.tar.gz' 
  source_sha1 '7efc7d56f4959de8bb33a92de2e15d92105eac32'

  depends_on 'buildessential'
  depends_on 'make'
  depends_on 'binutils'
  depends_on 'diffutils'
  depends_on 'glibc'
  depends_on 'gawk'
  depends_on 'gcc'
  depends_on 'pkgconfig'

  def self.build  
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "sed -i '/INSTALL_DATA.*libpcap.a\|RANLIB.*libpcap.a/ s/^/#/' Makefile"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
