require 'package'

class Pngcheck < Package
  description 'pngcheck verifies the integrity of PNG, JNG and MNG files'
  homepage 'http://www.libpng.org/pub/png/apps/pngcheck.html'
  version '2.3.0'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/png-mng/pngcheck/2.3.0/pngcheck-2.3.0.tar.gz'
  source_sha256 '77f0a039ac64df55fbd06af6f872fdbad4f639d009bbb5cd5cbe4db25690f35f'

  def self.build
    system "gcc -O -DUSE_ZLIB -I#{CREW_PREFIX}/include -o pngcheck pngcheck.c -L#{CREW_LIB_PREFIX} -lz"
  end

  def self.install
    system "install -Dm755 pngcheck #{CREW_DEST_PREFIX}/bin/pngcheck"
  end
end
