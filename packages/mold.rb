# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.11.0-4610013'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag '461001328bccf3b61709ee4531c6768c5280e289'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.11.0-4610013_armv7l/mold-1.11.0-4610013-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.11.0-4610013_armv7l/mold-1.11.0-4610013-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.11.0-4610013_i686/mold-1.11.0-4610013-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.11.0-4610013_x86_64/mold-1.11.0-4610013-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cbe0e18bcd3a58d72342e4369d4cd42a2017f352a96daaebb60c7016cdc98409',
     armv7l: 'cbe0e18bcd3a58d72342e4369d4cd42a2017f352a96daaebb60c7016cdc98409',
       i686: 'ef84fd60c77e04d7ba97f171b7a6bd353d4ac23ab0e8912c8d97dd91b403d2b4',
     x86_64: 'f3bdf8618e34e7aa23ddcfdd94e6576e3e052fc9a467eba50e2afca2a078451c'
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
      MOLD_JOBS=1
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
