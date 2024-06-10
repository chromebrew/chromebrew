# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'buildsystems/cmake'

class Mold < CMake
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '2.32.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44c82428bcf5b1d900c110650d41ccf562d3abfe486b68859cc96a386f511e05',
     armv7l: '44c82428bcf5b1d900c110650d41ccf562d3abfe486b68859cc96a386f511e05',
       i686: '50a97904e5db1d857f4390506ddfcf875c9699879ac2fbaeb55154a26e90dbe8',
     x86_64: 'ba8e8d65a0e65debac4a122ab25ea64619958a34ebed361d9073a0da0c74dff6'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'xxhash' => :build
  depends_on 'zlibpkg' # R
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
