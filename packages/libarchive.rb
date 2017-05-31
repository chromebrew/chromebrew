require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'http://www.libarchive.org/'
  version '3.2.2'
  source_url 'http://www.libarchive.org/downloads/libarchive-3.2.2.tar.gz'
  source_sha1 'ccf14e3b4ec7c6b242cf07062dd40e82a17485a5'

  depends_on "acl"
  depends_on "attr"
  depends_on "lz4"

  def self.build
    system "./configure --prefix=/usr/local --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
