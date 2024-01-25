# Adapted from Arch Linux libcdio-paranoia PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libcdio-paranoia/trunk/PKGBUILD

require 'package'

class Libcdio_paranoia < Package
  description 'CD paranoia libraries from libcdio'
  homepage 'https://www.gnu.org/software/libcdio/'
  version '10.2-2.0.1-1'
  license 'GPLv3'
  compatibility 'all'
  source_url 'https://github.com/rocky/libcdio-paranoia/archive/release-10.2+2.0.1.tar.gz'
  source_sha256 '7a4e257c85f3f84129cca55cd097c397364c7a6f79b9701bbc593b13bd59eb95'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4098fbea318ee03de6ccecbf8bae3a1075ab9f42fc5a7fe6a02f2016aba2ab4d',
     armv7l: '4098fbea318ee03de6ccecbf8bae3a1075ab9f42fc5a7fe6a02f2016aba2ab4d',
       i686: '825a103125f4c22eec50202f9ca8da9d5a287f54e8bbc6da24202da53bc5ca90',
     x86_64: 'e5f50c96babd9bdcc74f92de9ea9ac6a58372c858ae79c40292f6726a44d76ea'
  })

  depends_on 'libcdio'

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system " ./configure #{CREW_OPTIONS} \
      --enable-cpp-progs \
      --disable-example-progs"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
