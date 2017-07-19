require 'package'

class Apriconv < Package
  description 'a portable implementation of the iconv() library'
  homepage 'http://apr.apache.org/'
  version '1.2.1'
  source_url 'http://apache.claz.org/apr/apr-iconv-1.2.1.tar.bz2'
  source_sha256 'c46c919bc2a36a705f91f4dea444b18a83236eef97a417528a988113b3a7e46e'

  depends_on 'apr'
  depends_on 'libtool'

  def self.build
    system './configure \
            --prefix=/usr/local \
            --with-apr=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "libtool --mode=finish #{CREW_DEST_DIR}/usr/local/lib/iconv"
  end
end
