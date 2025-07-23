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
    aarch64: '002f0e21380cacb6e13e3bc52615a9a586608cb46bb3b941643a6cf3af3e5b71',
     armv7l: '002f0e21380cacb6e13e3bc52615a9a586608cb46bb3b941643a6cf3af3e5b71',
       i686: 'ff3b4f47e3cf0efddf4ff443ef89bb0e29cdab387694d72f4aeae8e185152d4d',
     x86_64: 'c17c253eea4829b4078e5969ab27bf2ffff600d16bba66d924b85144d20ec0e6'
  })

  depends_on 'gcc_lib' # R
  depends_on 'git' => :build
  depends_on 'glibc' # R
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
