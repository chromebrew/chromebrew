# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '2.0.0'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/2.0.0_armv7l/mold-2.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/2.0.0_armv7l/mold-2.0.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/2.0.0_i686/mold-2.0.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/2.0.0_x86_64/mold-2.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c7d7239513d8553687ea2e4a3952edff8580e8b8c56737dd659df9b0fb998af4',
     armv7l: 'c7d7239513d8553687ea2e4a3952edff8580e8b8c56737dd659df9b0fb998af4',
       i686: '50e491c45a287c77fd3ca465c70e9b812a11d1bced91bc26a873a81640d35802',
     x86_64: 'be95ffb532dd7efc524796321757a77be5113390d9cc65b0ad69f03e66667b73'
  })

  depends_on 'zlibpkg' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'gcc_lib' # R
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
