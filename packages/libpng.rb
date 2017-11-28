require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  version '1.6.34'
  source_url 'https://sourceforge.net/projects/libpng/files/libpng16/1.6.34/libpng-1.6.34.tar.xz'
  source_sha256 '2f1e960d92ce3b3abd03d06dfec9637dfbd22febf107a536b44f7a47c60659f6'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'zlibpkg'

  def self.build
      system './configure',
        "--prefix=#{CREW_PREFIX}",
        "--libdir=#{CREW_LIB_PREFIX}",
        '--disable-dependency-tracking',
        '--disable-maintainer-mode'
      system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
