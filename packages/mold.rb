# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.9.0'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold/archive/v1.9.0.tar.gz'
  source_sha256 'faf381ba268e714bec7f872de0dd6ea9187ae20b4e12c434a67ac92854701280'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.9.0_armv7l/mold-1.9.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.9.0_armv7l/mold-1.9.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.9.0_i686/mold-1.9.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.9.0_x86_64/mold-1.9.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8ea399fa7d6c994dfcacdbafd50a13c72be8dbdd050cd05e2435985bfd256d62',
     armv7l: '8ea399fa7d6c994dfcacdbafd50a13c72be8dbdd050cd05e2435985bfd256d62',
       i686: '40d555610a40e4316064ce26ecd2259d6c5fc651377bee4238b5283739b6a8e8',
     x86_64: 'f31c42d4b87c1e3d77d4f113b7804ced503c3d992191ca1e4c1f765040b5e38b'
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
