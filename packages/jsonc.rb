require 'package'

class Jsonc < Package
  version '0.12.1-nodoc'
  source_url 'https://s3.amazonaws.com/json-c_releases/releases/json-c-0.12.1-nodoc.tar.gz'
  source_sha1 'ffb24acc03110703a88657a64507cc055373f252'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
