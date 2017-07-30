require 'package'

class Trousers < Package
  description 'The open-source TCG Software Stack.'
  homepage 'http://trousers.sourceforge.net/'
  version '0.3.14-1'
  source_url 'https://downloads.sourceforge.net/project/trousers/trousers/0.3.14/trousers-0.3.14.tar.gz'
  source_sha256 'ce50713a261d14b735ec9ccd97609f0ad5ce69540af560e8c3ce9eb5f2d28f47'

  depends_on 'openssl'
  depends_on 'libtool'
  depends_on 'pkgconfig'

  def self.build
    system "./configure", "--disable-static", "--with-gui=none",
      "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
