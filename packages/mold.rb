# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '2.31.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '677813fbb16364c9c199dfe9923f94fce929492cd713c13d03ec75e169224b7a',
     armv7l: '677813fbb16364c9c199dfe9923f94fce929492cd713c13d03ec75e169224b7a',
       i686: 'bdc22bd3b22f84fbd622a7cb006d76052b9b03e03f7a7c3cffce092d284b8ff7',
     x86_64: '3fb317bfa36dacfca24d1670e8fc66aed3828738b4c6da276075b8ea9e83a6cf'
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
