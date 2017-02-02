require 'package'

class Libxml2 < Package
  version '2.9.2-1'
  source_url 'http://xmlsoft.org/sources/libxml2-2.9.2.tar.gz'
  source_sha1 'f46a37ea6d869f702e03f393c376760f3cbee673'

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
