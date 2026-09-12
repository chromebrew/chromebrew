# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'buildsystems/cmake'

class Mold < CMake
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '2.42.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c8e64f1a7557128712067fbed8d3bfb7aa949c570124d2fae1b9ef30f794c72e',
     armv7l: 'c8e64f1a7557128712067fbed8d3bfb7aa949c570124d2fae1b9ef30f794c72e',
       i686: '54c0ecfebf0730c9cc4f583e1aa8b85d265d4f9ba7a07c7395dc0f14567605c6',
     x86_64: '4f1625150dff572edc37f4ffdf686e793147044227c1ab8159840e64f6f99efe'
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
