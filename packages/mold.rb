# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.8.0'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold/archive/v1.8.0.tar.gz'
  source_sha256 '7210225478796c2528aae30320232a5a3b93a640292575a8c55aa2b140041b5c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.8.0_armv7l/mold-1.8.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.8.0_armv7l/mold-1.8.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.8.0_i686/mold-1.8.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.8.0_x86_64/mold-1.8.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0dc0d5b9cdb83e64dea3ffc1a1a7e4c770d1747931417306e90860a23b3ae986',
     armv7l: '0dc0d5b9cdb83e64dea3ffc1a1a7e4c770d1747931417306e90860a23b3ae986',
       i686: '0b49d793b32e2c0ab9ee7b74eda2cfaf20be9744c6a04940ddea4a853f96ab82',
     x86_64: '513df9d98f9c0bc24d98c5a1c9b578a2a4c03ab971151910e68c582cb32fcdef'
  })

  depends_on 'zlibpkg' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'gcc' # R
  depends_on 'xxhash' => :build
  depends_on 'zstd' # R

  no_env_options

  def self.build
    FileUtils.mkdir_p 'builddir'
    Dir.chdir('builddir') do
      # TBB build option due to
      # https://github.com/oneapi-src/oneTBB/issues/843#issuecomment-1152646035
      system "cmake #{CREW_CMAKE_OPTIONS} \
        -DBUILD_TESTING=OFF \
        -DMOLD_LTO=ON \
        -DMOLD_USE_MOLD=ON \
        -DTBB_WARNING_LEVEL='-Wno-error=stringop-overflow' \
        -Wno-dev \
        ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
