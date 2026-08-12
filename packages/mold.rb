# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'buildsystems/cmake'

class Mold < CMake
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '2.42.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ee4b4296589b39e262a641c80fd8d700609e7702d9b544f2c9cac81e0a18ae20',
     armv7l: 'ee4b4296589b39e262a641c80fd8d700609e7702d9b544f2c9cac81e0a18ae20',
       i686: '28cbd828b5e133d461a92c242d9156036aa437a28f609acf10050225dbef5f6d',
     x86_64: 'ab20e207afe628d712f5174e955ecc0a1bbbc96022aa0391c354b5eb3b108fd5'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'xxhash' => :build
  depends_on 'zlib' => :executable
  depends_on 'zlib' => :library
  depends_on 'zstd' => :executable
  depends_on 'zstd' => :library

  no_env_options
  print_source_bashrc

  cmake_options "-DBUILD_TESTING=OFF \
        -DMOLD_LTO=ON \
        -DMOLD_USE_MOLD=ON \
        -DTBB_WARNING_LEVEL='-Wno-error=stringop-overflow'"

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    File.write 'moldenv', <<~MOLD_ENV_EOF
      # See https://github.com/rui314/mold/commit/36fc0655489eb96e1be15b03b3f5e227cd97a22e
      if [[ $(free | head -n 2 | tail -n 1 | awk '{print $4}') -gt '4096000' ]]; then
        unset MOLD_JOBS
      else
        MOLD_JOBS=1
      fi
    MOLD_ENV_EOF
    FileUtils.install 'moldenv', "#{CREW_DEST_PREFIX}/etc/env.d/mold", mode: 0o644
  end
end
