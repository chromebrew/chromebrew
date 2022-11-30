# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.7.0'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold/archive/v1.7.0.tar.gz'
  source_sha256 'ccd685afcdb7047f8a8ce8b5ce3b3cd22205a0ebc548ff1f1da7b35415fafbe4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.7.0_armv7l/mold-1.7.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.7.0_armv7l/mold-1.7.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.7.0_i686/mold-1.7.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.7.0_x86_64/mold-1.7.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cb08d29a755b7cccff57fede11055974e1ba27377750ab2211705d7cfb895e01',
     armv7l: 'cb08d29a755b7cccff57fede11055974e1ba27377750ab2211705d7cfb895e01',
       i686: '93a04584314969d2b9dcf6da676b06b9bb70a2b76038995504592f5dab4641f4',
     x86_64: '52eda67fa0256bd21be68b78f29d065d02b5b8365dc5a09ab9155b0ff7ef8339'
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
