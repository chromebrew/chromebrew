require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  version '1.6.33'
  source_url 'http://prdownloads.sourceforge.net/libpng/libpng-1.6.33.tar.gz'
  source_sha256 '6a6bacae7510dd53321af0604182b6c731a09457e3ddb8d9668bbce614a2751f'

  binary_url ({
  })
  binary_sha256 ({
  })

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
