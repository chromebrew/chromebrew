# Adapted from Arch Linux tree-sitter PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/tree-sitter/trunk/PKGBUILD

require 'package'

class Tree_sitter < Package
  description 'An incremental parsing system for programming tools'
  homepage 'https://github.com/tree-sitter/tree-sitter'
  version '0.26.6'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/tree-sitter/tree-sitter.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1be3e8607fdd96f6d3249c09267bc24546b0242f6091da15379fe0c48ed7471b',
     armv7l: '1be3e8607fdd96f6d3249c09267bc24546b0242f6091da15379fe0c48ed7471b',
       i686: 'f57bbeedad8fa359a08be2b9a0d988ec3526ea634df88e534850b64968d1131c',
     x86_64: '03e9eb15339a6e4dd85b5ccbe261f09f3e7871cfe0828f978cc5420b60b6dd0e'
  })

  depends_on 'gcc_lib' => :executable_only
  depends_on 'git' => :build
  depends_on 'glibc' # R
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
