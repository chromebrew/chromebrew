# Adapted from Arch Linux tree-sitter PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/tree-sitter/trunk/PKGBUILD

require 'package'

class Tree_sitter < Package
  description 'An incremental parsing system for programming tools'
  homepage 'https://github.com/tree-sitter/tree-sitter'
  version '0.27.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/tree-sitter/tree-sitter.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bb48d0e354945e6e4f89f6e7562642f9e254db6641a7fe677de87c456f3053a4',
     armv7l: 'bb48d0e354945e6e4f89f6e7562642f9e254db6641a7fe677de87c456f3053a4',
       i686: '05a0ae5c06508033af232a34ac6511a387b6f09c658a0402abb7731eebb6d1c6',
     x86_64: 'c4d4e76ce5068e743e165002739505cf95f41da75c842da4601de5894813be65'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'git' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'llvm' => :build
  depends_on 'nodebrew' => :logical # Needed for packages that use tree_sitter.
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
