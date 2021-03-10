require 'package'

class Libmfx < Package
  description 'Intel Media SDK dispatcher library'
  homepage 'https://github.com/lu-zero/mfx_dispatch/'
  version '1.25'
  compatibility 'x86_64 i686'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'https://github.com/lu-zero/mfx_dispatch/archive/1.25.tar.gz'
    source_sha256 '853c4555c800a262fedacc580d06c234c520a919e4497b50e555291d87579a42'
    depends_on 'libva'
  end

  binary_url({
    i686: 'https://dl.bintray.com/chromebrew/chromebrew/libmfx-1.25-chromeos-i686.tar.xz',
  x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libmfx-1.25-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    i686: '3eab119d8be510a2786d31419c20c551a0629f3b8d8d4fa58a2fb31b3f66a960',
  x86_64: '65246a1f81384d7b241800f406013a7e13920c82d9d136beb74a4edfd924dd59'
  })

  def self.build
    system 'autoreconf -i'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --enable-shared='yes' \
      --with-libva_drm='yes' \
      --with-libva_x11='yes' \
      --with-pic"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    # fix version in pkg-config file"
    system "sed -i /Version:/s/[0-9]\.[0-9]\{2\}/1.25/ #{CREW_DEST_LIB_PREFIX}/pkgconfig/libmfx.pc"
  end
end
