# Adapted from Arch Linux faac PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/faac/trunk/PKGBUILD

require 'package'

class Faac < Package
  description 'Freeware Advanced Audio Coder'
  homepage 'https://www.audiocoding.com/'
  version '1.30'
  license 'GPL2 custom'
  compatibility 'all'
  source_url 'https://github.com/knik0/faac/archive/refs/tags/1_30.tar.gz'
  source_sha256 'adc387ce588cca16d98c03b6ec1e58f0ffd9fc6eadb00e254157d6b16203b2d2'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/faac/1.30_armv7l/faac-1.30-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/faac/1.30_armv7l/faac-1.30-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/faac/1.30_i686/faac-1.30-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/faac/1.30_x86_64/faac-1.30-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0964049377f4cb3a818b5448e0e072dffeae95919261837ad28c7135db9a441a',
     armv7l: '0964049377f4cb3a818b5448e0e072dffeae95919261837ad28c7135db9a441a',
       i686: 'f3e919c4f4f06777d43b3d02a6cf3a12b162440b40243de24383730ad308a182',
     x86_64: 'fdea955a9dfd5732dc22a40ec8ff8aef47c153b5f34b7cff7f2aa9d6e0e3f05a'
  })

  depends_on 'glibc'

  def self.build
    system 'autoreconf -vfi'
    system "env #{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
