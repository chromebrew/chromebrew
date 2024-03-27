# Adapted from Arch Linux tree-sitter PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/tree-sitter/trunk/PKGBUILD

require 'package'

class Tree_sitter < Package
  description 'An incremental parsing system for programming tools'
  homepage 'https://github.com/tree-sitter/tree-sitter'
  version '0.22.2-0fc92c9'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/tree-sitter/tree-sitter.git'
  git_hashtag '0fc92c9a7d0ddb417bd74bf7f533bb8f3042dbe3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e22f7f79b3552aca673a5cea9810278f219d9a59ba07a447b73219de0a73716e',
     armv7l: 'e22f7f79b3552aca673a5cea9810278f219d9a59ba07a447b73219de0a73716e',
       i686: '6058155f927d6d35739f8dd5cdee46a28b6e107280e3e41e99e97cbb235cbe8d',
     x86_64: 'c566a6d63c2153d034598c54e18a4df3b56d77b07fa0feaa611c736e029e05b9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'git' => :build
  depends_on 'glibc' # R
  depends_on 'rust' => :build

  def self.patch
    system "sed -i 's,PREFIX)/lib,PREFIX)/#{ARCH_LIB},' Makefile"
  end

  def self.build
    system 'cargo install tree-sitter-cli'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} install"
  end
end
