# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'package'

class Upx < Package
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '4.0.3-f4c4d51'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag 'f4c4d5148e4f8c9fc5bfd2c2e836ee2aa27fbaab'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.3-f4c4d51_armv7l/upx-4.0.3-f4c4d51-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.3-f4c4d51_armv7l/upx-4.0.3-f4c4d51-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.3-f4c4d51_i686/upx-4.0.3-f4c4d51-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.3-f4c4d51_x86_64/upx-4.0.3-f4c4d51-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a6eb586e86e3566185e16873529325bc4828cf1542c02c1347eec9ef06f68309',
     armv7l: 'a6eb586e86e3566185e16873529325bc4828cf1542c02c1347eec9ef06f68309',
       i686: '83bf7c39b72055cd7e035d8d70def2c82252151edd3cc0f6f203cac7b35c47dc',
     x86_64: 'f68d21c492b38e8a7e05cf02ac74455dc60799bd7734f942b188cff8b8992f84'
  })

  # depends_on 'ucl'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
      -DUPX_CONFIG_DISABLE_GITREV=true \
      -G Ninja"
    system 'samu -C builddir'
  end

  def self.check
    # samu does not work here.
    system 'ninja test -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
