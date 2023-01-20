# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.10.0'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold/archive/v1.10.0.tar.gz'
  source_sha256 'bcf59e21cebf2b7e7346ccfd1803865e411b8a35b5a2cb581936c4ace3d2bac8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.10.0_armv7l/mold-1.10.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.10.0_armv7l/mold-1.10.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.10.0_i686/mold-1.10.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.10.0_x86_64/mold-1.10.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7a4df748b3fce2671323c24416cc87770fdfbb305801bccece21d436211b28e5',
     armv7l: '7a4df748b3fce2671323c24416cc87770fdfbb305801bccece21d436211b28e5',
       i686: 'fbfa1512e93307f0c8bb68c78606614fa66e993cf464228135be740363a378cd',
     x86_64: '4edee779e458582b8386550b5e7ff98153dbb1ab474437d64b909d81a4aff8d2'
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
