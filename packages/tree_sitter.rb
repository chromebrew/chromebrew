# Adapted from Arch Linux tree-sitter PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/tree-sitter/trunk/PKGBUILD

require 'package'

class Tree_sitter < Package
  description 'An incremental parsing system for programming tools'
  homepage 'https://github.com/tree-sitter/tree-sitter'
  version '0.27.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/tree-sitter/tree-sitter.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '565d1488059f0a4babd1e5704e2cb82c01895d2a529d5b43be476514083638be',
     armv7l: '565d1488059f0a4babd1e5704e2cb82c01895d2a529d5b43be476514083638be',
       i686: '90e6225beb3138da7b1d7a9409c6ac7a80a0747cc12572ec297690722015c83e',
     x86_64: 'ac8af43cd6f2b9759c2a860371ee2de5488a3e75cf4a89c6c2df87881950fdc5'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'git' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'llvm' => :build
  depends_on 'rust' => :build

  def self.patch
    system "sed -i 's,PREFIX)/lib,PREFIX)/#{ARCH_LIB},' Makefile"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} install"
    system "cargo install \
        --no-track \
        --profile=release \
        --root #{CREW_DEST_PREFIX}\
        tree-sitter-cli"
  end
end
