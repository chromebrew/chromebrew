require 'package'

class Libpng < Package
  version '1.6.26'
  source_url 'http://prdownloads.sourceforge.net/libpng/libpng-1.6.26.tar.gz'
  source_sha1 '3b2652f89b8fdcb6c29e9ed7642dfcfc0bbcf17e'

  def self.build
      system "./configure --libdir=/usr/local/lib#{SHORTARCH}/ CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
