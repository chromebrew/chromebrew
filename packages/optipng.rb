require 'package'

class Optipng < Package
  version '0.7.6'
  source_url 'http://prdownloads.sourceforge.net/optipng/optipng-0.7.6.tar.gz'
  source_sha1 '3b3e31430e735589470c4af204354d38823f4989'

  # NOTE: uses libpng and zlib but uses its own versions of those libraries

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
