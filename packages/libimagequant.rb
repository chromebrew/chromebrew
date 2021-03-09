# Adapted from Arch Linux libimagequant PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libimagequant/trunk/PKGBUILD

require 'package'

class Libimagequant < Package
  description 'Library for high-quality conversion of RGBA images to 8-bit indexed-color palette images'
  homepage 'https://pngquant.org/lib/'
  version '2.14.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/ImageOptim/libimagequant/archive/2.14.1/libimagequant-2.14.1.tar.gz'
  source_sha256 'b5fa27da1f3cf3e8255dd02778bb6a51dc71ce9f99a4fc930ea69b83200a7c74'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libimagequant-2.14.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libimagequant-2.14.1-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libimagequant-2.14.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'eeff7663ff38b663fef766a1244ea4c0be6c465cd216f9f5b0409affd9f03ae3',
     armv7l: 'eeff7663ff38b663fef766a1244ea4c0be6c465cd216f9f5b0409affd9f03ae3',
     x86_64: 'a684ca8eeeb2a38a696eb8a1b3395e0d08929ef219c17df23ac87fbd6989d963'
  })

  def self.build
    # system "sed -r 's/^install:.*/install:/;/install.*STATICLIB/d' -i Makefile"
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} --with-openmp"
    system 'make shared imagequant.pc'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} PREFIX=/usr install"
  end
end
