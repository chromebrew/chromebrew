# Adapted from Arch Linux tree-sitter PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/tree-sitter/trunk/PKGBUILD

require 'package'

class Tree_sitter < Package
  description 'An incremental parsing system for programming tools'
  homepage 'https://github.com/tree-sitter/tree-sitter'
  version '0.26.8'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/tree-sitter/tree-sitter.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '254d04b1e29a58015d0cd9efe605a4a0cbc1bf1c71371487f67f943f0021b5ba',
     armv7l: '254d04b1e29a58015d0cd9efe605a4a0cbc1bf1c71371487f67f943f0021b5ba',
       i686: 'ac35ef12ba48177bbc325e030cd4fc14b5729b5972e803ab983ee051be3f07d7',
     x86_64: '4ff0ea218e624831f760be2c003683a724110f6dd278c84402a53c765dc97d05'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'git' => :build
  depends_on 'glibc' => :library
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
