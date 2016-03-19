require 'package'

class Linuxheaders < Package
  version '3.14'
  source_url 'https://github.com/torvalds/linux/archive/v3.14.tar.gz'
  source_sha1 'd288a841d097c16b471bf4cda4315566c42cdebc'

  def self.build
    system "./configure CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "headers_install"
  end
end
