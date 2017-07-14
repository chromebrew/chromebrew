require 'package'

class Optipng < Package
  description 'OptiPNG is a PNG optimizer that recompresses image files to a smaller size, without losing any information.'
  homepage 'http://optipng.sourceforge.net/'
  version '0.7.6-1'
  source_url 'http://prdownloads.sourceforge.net/optipng/optipng-0.7.6.tar.gz'
  source_sha256 '4870631fcbd3825605f00a168b8debf44ea1cda8ef98a73e5411eee97199be80'

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
