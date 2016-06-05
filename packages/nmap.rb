require 'package'

class Nmap < Package
  version '6.47'
  # maintainer 'Bruno Fosados <bruno.fosados@gmail.com>'

  binary_url ({
    x86_64: 'https://dl.bintray.com/brunux/chromebrew/nmap-6.47-chromebrew.tar.gz'
  })
  binary_sha1 ({
    x86_64: '8fb18d44bb0d73bb1563eb77d83725a44d2d5745'
  })

  source_url 'https://dl.bintray.com/brunux/chromebrew/libpcap-1.6.2-src.tar.gz' 
  source_sha1 '0c917453a91a5e85c2a217d27c3853b0f3e0e6ac'

  depends_on 'libpcap'
  depends_on 'pcre'
  depends_on 'lua'
  depends_on 'openssl'
  depends_on 'python27'

  def self.build  
    system "./configure --prefix=/usr/local/ --with-liblua=included"
    system "make -j1"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

