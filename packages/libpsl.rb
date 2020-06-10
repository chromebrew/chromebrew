require 'package'

class Libpsl < Package
  description 'C library for the Public Suffix List'
  homepage 'https://github.com/rockdaboot/libpsl'
  version '0.20.2'
  compatibility 'all'
  source_url 'https://github.com/rockdaboot/libpsl/releases/download/libpsl-0.20.2/libpsl-0.20.2.tar.gz'
  source_sha256 'f8fd0aeb66252dfcc638f14d9be1e2362fdaf2ca86bde0444ff4d5cc961b560f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpsl-0.20.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpsl-0.20.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpsl-0.20.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpsl-0.20.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f6dab3749e5e195e417775c03870738aef36454f5124e59708c70a006b417b9c',
     armv7l: 'f6dab3749e5e195e417775c03870738aef36454f5124e59708c70a006b417b9c',
       i686: '51e81940423ac5bf3de3a931f697d1b0962a74be326f7cf0685f0328d97b7dab',
     x86_64: 'f7f422c26f3d5b3cf690a6f9db6245f32ec7700d1db8e2b33eac212ca00c422e',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
