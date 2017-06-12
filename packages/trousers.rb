require 'package'

class Trousers < Package
  description 'The open-source TCG Software Stack.'
  homepage 'http://trousers.sourceforge.net/'
  version '0.3.14'
  source_url 'https://downloads.sourceforge.net/project/trousers/trousers/0.3.14/trousers-0.3.14.tar.gz'
  source_sha1 '9ca2cc9e1179465f6c5d9055e2b855e25031b85a'

  depends_on 'openssl'
  depends_on 'libtool'
  depends_on 'pkgconfig'

  def self.build
    system './configure --prefix=/usr/local --with-gui=none'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
