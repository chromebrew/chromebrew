# Adapted from Arch Linux tree-sitter PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/tree-sitter/trunk/PKGBUILD

require 'package'

class Tree_sitter < Package
  description 'An incremental parsing system for programming tools'
  homepage 'https://github.com/tree-sitter/tree-sitter'
  version '0.27.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/tree-sitter/tree-sitter.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '88b7765fe0748147abadb7f750d45728b4ca4f50d313d5a920240929dfb12d45',
     armv7l: '88b7765fe0748147abadb7f750d45728b4ca4f50d313d5a920240929dfb12d45',
       i686: '71d4cda7c35ae5feaa463360ea26eb099b806674527784c051304124e0168cb4',
     x86_64: 'b47bba75099a8117129bf3451770dcdb6fec3a7a9f1019e80d459761479a4672'
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
