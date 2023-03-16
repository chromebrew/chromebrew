# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.11.0'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold/archive/v1.11.0.tar.gz'
  source_sha256 '99318eced81b09a77e4c657011076cc8ec3d4b6867bd324b8677974545bc4d6f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.11.0_armv7l/mold-1.11.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.11.0_armv7l/mold-1.11.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.11.0_i686/mold-1.11.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.11.0_x86_64/mold-1.11.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7bd4c1795aa79bb4bc9c9ef47a28e67f9b0d5436ea6bd94f8260fb2742f845d0',
     armv7l: '7bd4c1795aa79bb4bc9c9ef47a28e67f9b0d5436ea6bd94f8260fb2742f845d0',
       i686: 'bdb93a3a2b4e2274864cb34dd866a7ef09f49e98606044496781a81eb25c5471',
     x86_64: '4de15897106e82fdebd436ace4d442f5ed7b959b4b6f752f85dd41e413afef25'
  })

  depends_on 'zlibpkg' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'gcc' # R
  depends_on 'xxhash' => :build
  depends_on 'zstd' # R

  no_env_options

  def self.build
    # TBB build option due to
    # https://github.com/oneapi-src/oneTBB/issues/843#issuecomment-1152646035
    system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
        -DBUILD_TESTING=OFF \
        -DMOLD_LTO=ON \
        -DMOLD_USE_MOLD=ON \
        -DTBB_WARNING_LEVEL='-Wno-error=stringop-overflow' \
        -Wno-dev \
        -G Ninja"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
