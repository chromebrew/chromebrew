# Adapted from Arch Linux libcdio-paranoia PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libcdio-paranoia/trunk/PKGBUILD

require 'package'

class Libcdio_paranoia < Package
  description 'CD paranoia libraries from libcdio'
  homepage 'https://www.gnu.org/software/libcdio/'
  version '10.2-2.0.1'
  license 'GPLv3'
  compatibility 'all'
  source_url 'https://github.com/rocky/libcdio-paranoia/archive/release-10.2+2.0.1.tar.gz'
  source_sha256 '7a4e257c85f3f84129cca55cd097c397364c7a6f79b9701bbc593b13bd59eb95'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdio_paranoia/10.2-2.0.1_armv7l/libcdio_paranoia-10.2-2.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdio_paranoia/10.2-2.0.1_armv7l/libcdio_paranoia-10.2-2.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdio_paranoia/10.2-2.0.1_i686/libcdio_paranoia-10.2-2.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdio_paranoia/10.2-2.0.1_x86_64/libcdio_paranoia-10.2-2.0.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8ba30c99931a347744767a197b49cb14cb3459e7997928bb4377acc2082afeaf',
     armv7l: '8ba30c99931a347744767a197b49cb14cb3459e7997928bb4377acc2082afeaf',
       i686: '9fde7bf09aa6023ca6128088ec9f1e1be2df36b4a2d7b596f20d448a11124044',
     x86_64: '6b324873fd7c441d6aaedb03463c19267d1352cf73af95d872808ff5de4ee35b'
  })

  depends_on 'libcdio'

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --enable-cpp-progs \
      --disable-example-progs"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
