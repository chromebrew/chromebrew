# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.11.0-dce8ebe'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag 'dce8ebe5265b615f35999272d3dc666b1c246ff4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.11.0-dce8ebe_armv7l/mold-1.11.0-dce8ebe-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.11.0-dce8ebe_armv7l/mold-1.11.0-dce8ebe-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.11.0-dce8ebe_i686/mold-1.11.0-dce8ebe-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.11.0-dce8ebe_x86_64/mold-1.11.0-dce8ebe-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'df0c064788a64611a0b7f051bac1601350b42ab8567f739a369f623443a52495',
     armv7l: 'df0c064788a64611a0b7f051bac1601350b42ab8567f739a369f623443a52495',
       i686: '450456d45ac0ffc4a0dbeafd7c6a404263932aa436828550915a63a253998c80',
     x86_64: '8851d9188f83533dbf94000b9960a2cba816e46493d91297f092eba97d178f8f'
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

  def self.postinstall
    puts "\nTo finish the installation, execute the following:".lightblue
    puts "source ~/.bashrc\n".lightblue
  end
end
