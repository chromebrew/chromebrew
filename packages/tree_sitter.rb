# Adapted from Arch Linux tree-sitter PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/tree-sitter/trunk/PKGBUILD

require 'package'

class Tree_sitter < Package
  description 'An incremental parsing system for programming tools'
  homepage 'https://github.com/tree-sitter/tree-sitter'
  version '0.20.7'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/tree-sitter/tree-sitter.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e096d53784489397c39f249694d76e4a3f6a4b79d51a6f4b6e9a4be0d9615c5b',
     armv7l: 'e096d53784489397c39f249694d76e4a3f6a4b79d51a6f4b6e9a4be0d9615c5b',
       i686: '4d2c9d9708b9766c6033b4665fbee5fa87927118256acb65c2118fd0ad045bf7',
     x86_64: '51fa29522e221124f3a6f2746b4d8bb88e2c9c110d7a31c068072c4d0c81c0fc'
  })

  depends_on 'git' => :build
  depends_on 'rust' => :build

  def self.patch
    system "sed -i 's,PREFIX)/lib,PREFIX)/#{ARCH_LIB},' Makefile"
  end

  def self.build
    system 'cargo fetch --locked'
    system 'make'
    Dir.chdir 'cli' do
      system 'cargo build --release --locked --offline --all-features'
    end
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'target/release/tree-sitter', "#{CREW_DEST_PREFIX}/bin/tree-sitter", mode: 0o755
  end
end
