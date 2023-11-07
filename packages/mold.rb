# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '2.3.2-0c6daad'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag '0c6daad215d0b0d4f835e33366d41a9218212367'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/2.3.2_armv7l/mold-2.3.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/2.3.2_armv7l/mold-2.3.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/2.3.2_i686/mold-2.3.2-chromeos-i686.tar.zst',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/2.3.2-0c6daad_x86_64/mold-2.3.2-0c6daad-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd3da641a7e37663a989bf0ecacecd37a7bf087fbbc199b5c8afc975c729f5647',
     armv7l: 'd3da641a7e37663a989bf0ecacecd37a7bf087fbbc199b5c8afc975c729f5647',
       i686: '63293b849ec265b40453fa3fbdde565e322bd56725079e24a27d80cfc7a82de2',
    x86_64: '5772b5cb14ca2dfa2946edf2c3f7c7fd5366256aabc0b2cd67bf71f997886ac9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'xxhash' => :build
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  no_env_options
  print_source_bashrc

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
    File.write 'moldenv', <<~MOLD_ENV_EOF
      # See https://github.com/rui314/mold/commit/36fc0655489eb96e1be15b03b3f5e227cd97a22e
      if [[ $(free | head -n 2 | tail -n 1 | awk '{print $4}') -gt '4096000' ]]; then
        unset MOLD_JOBS
      else
        MOLD_JOBS=1
      fi
    MOLD_ENV_EOF
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.install 'moldenv', "#{CREW_DEST_PREFIX}/etc/env.d/mold", mode: 0o644
  end
end
