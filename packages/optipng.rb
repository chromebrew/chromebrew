require 'package'

class Optipng < Package
  description 'OptiPNG is a PNG optimizer that recompresses image files to a smaller size, without losing any information.'
  homepage 'http://optipng.sourceforge.net/'
  version '0.7.6-1'
  source_url 'http://prdownloads.sourceforge.net/optipng/optipng-0.7.6.tar.gz'
  source_sha1 '3b3e31430e735589470c4af204354d38823f4989'
  
  depends_on 'libpng'
  depends_on 'zlibpkg'

  def self.build
    system "./configure --prefix=/usr/local --with-system-libpng" # Bundled libpng doesn't work on armv7l
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
