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
    aarch64: '208c67835efc58c76e6adc7ddd143f0b19601f71e0e2ba83a152c6a872accd01',
     armv7l: '208c67835efc58c76e6adc7ddd143f0b19601f71e0e2ba83a152c6a872accd01',
       i686: '0120e21f3ea7d4fb14f07d73cf7ed32242f5072c2cc62a9a94e3d50b3fe40c3a',
     x86_64: '2eb5b5945364dd9ca08223c2321314ff2bd9b875dee6b234738454f109a7cd53'
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
