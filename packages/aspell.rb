require 'package'

class Aspell < Package
  description 'GNU Aspell is a Free and Open Source spell checker designed to eventually replace Ispell.'
  homepage 'http://aspell.net/'
  version '0.60.8'
  source_url 'https://ftpmirror.gnu.org/aspell/aspell-0.60.8.tar.gz'
  source_sha256 'f9b77e515334a751b2e60daab5db23499e26c9209f5e7b7443b05235ad0226f2'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
