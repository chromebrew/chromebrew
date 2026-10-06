# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'buildsystems/rust'

class Mold < RUST
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '3.0.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea7495f3b599a3c69205215392ad6141005a9aa942fc854bd2a6207963e278d8',
     armv7l: 'ea7495f3b599a3c69205215392ad6141005a9aa942fc854bd2a6207963e278d8',
       i686: '58358ad2140f417ecfad657a2ba03a8ab2fdc922f5b27c1d7bc953bda0a9172f',
     x86_64: '52d63833f6cddddb719beac6b4219025f26a66446bb88bddf4531ad34c74e02b'
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

  print_source_bashrc

  pre_rust_options "MOLD_LIBDIR=#{CREW_LIB_PREFIX}"

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} MOLD_LIBDIR=#{CREW_LIB_PREFIX} PREFIX=#{CREW_PREFIX} ./install-mold.sh"
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
