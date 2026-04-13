# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'buildsystems/cmake'

class Mold < CMake
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '2.41.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2c178126fb01b077b2b2b42cdf0bef03ca7c5125651379ac94ba3a7b74ee3ad0',
     armv7l: '2c178126fb01b077b2b2b42cdf0bef03ca7c5125651379ac94ba3a7b74ee3ad0',
       i686: '84f2eb3b2b972eeb5e890e6964f1fa4bedaedbfb3115877fb7cef59c02ef8fb9',
     x86_64: 'c07531a67e75978a47e27a6a8765203fad31d2071b588e0dd6f58b15fff6ccfa'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'xxhash' => :build
  depends_on 'zlib' => :library
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
