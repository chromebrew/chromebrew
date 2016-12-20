require 'package'

class Bacon < Package
  version '3.5'
  source_url 'http://www.basic-converter.org/stable/bacon-3.5.tar.gz'
  source_sha1 '878da51d1f8bef9baea6523be8f09d8a616f8e9f'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
