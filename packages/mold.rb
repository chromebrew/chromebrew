# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'buildsystems/cmake'

class Mold < CMake
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '2.40.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a13cb59b2be7f54758b0c455cf632c3bc67b74714373329ee4c9f60e1291952f',
     armv7l: 'a13cb59b2be7f54758b0c455cf632c3bc67b74714373329ee4c9f60e1291952f',
       i686: '8d45f8efa9c8f5943c52a411b2bc41a27ee392731533e2100ff5b6bd6c5c1bd4',
     x86_64: '392e182dbb3d94c30a8b5a2d63afad18a7787f059aa154f60f6c2d48c097e0d9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'xxhash' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R



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
