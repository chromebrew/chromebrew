require 'package'

class Libxdmcp < Package
  description 'The libXdmcp package contains a library implementing the X Display Manager Control Protocol.'
  homepage 'http://www.x.org'
  version '1.1.2-0'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/lib/libXdmcp-1.1.2.tar.bz2'
  source_sha256 '81fe09867918fff258296e1e1e159f0dc639cb30d201c53519f25ab73af4e4e2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxdmcp-1.1.2-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxdmcp-1.1.2-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxdmcp-1.1.2-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxdmcp-1.1.2-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '409aa7e74743cd1ac2bc619bba6b6890a59d9e15c591ab8d548ddf7991354e1f',
     armv7l: '409aa7e74743cd1ac2bc619bba6b6890a59d9e15c591ab8d548ddf7991354e1f',
       i686: 'bb5fef68c987cca02dd84eb1cccf9f30598522b4932739f39d6126e2446c1179',
     x86_64: 'b9b1a87572a321a7ff1be4bcb9c20b25c67b4a80fb5fe8867d0f24d29ecce5ae',
  })

  depends_on "xorg_proto"

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
