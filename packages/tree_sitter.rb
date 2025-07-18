# Adapted from Arch Linux tree-sitter PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/tree-sitter/trunk/PKGBUILD

require 'package'

class Tree_sitter < Package
  description 'An incremental parsing system for programming tools'
  homepage 'https://github.com/tree-sitter/tree-sitter'
  version '0.25.8-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/tree-sitter/tree-sitter.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '96159bd716c4bb1a8b7ad954cc04a321d89a6e59263f7a1cc272c684ffc50eb6',
     armv7l: '96159bd716c4bb1a8b7ad954cc04a321d89a6e59263f7a1cc272c684ffc50eb6',
       i686: '5eafa9fbe527c2da819f8d9da5cf7565ac599f6644ce8065a83d74482f2b3c64',
     x86_64: '6edc69388f86d9c6c8cf011595f33a9a877e899aebd8e3757ba7326270b8a5f7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'git' => :build
  depends_on 'glibc' # R
  depends_on 'rust' => :build

  def self.build
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
