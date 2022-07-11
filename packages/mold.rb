# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.3.1'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.3.1_armv7l/mold-1.3.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.3.1_armv7l/mold-1.3.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.3.1_i686/mold-1.3.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.3.1_x86_64/mold-1.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'afa9fd04d9904f655570cc4b4647c00fdaf2ddb9376bd976bdc794d25dff07c0',
     armv7l: 'afa9fd04d9904f655570cc4b4647c00fdaf2ddb9376bd976bdc794d25dff07c0',
       i686: '94932dc5409ce8c1bc066df0d84fcb0b45a830490a037c2c2fd0bcd120175ce1',
     x86_64: '3f9fc41d8d4a97eabb1b07d21805014bd297e2a1acd302893cec1696d8c5aace'
  })

  depends_on 'zlibpkg' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'gcc' # R
  depends_on 'xxhash' => :build
  no_env_options

  def self.patch
    system "sed -i 's,PREFIX = /usr/local,PREFIX = #{CREW_PREFIX},g' Makefile"
    system "sed -i 's,LIBDIR = \$(PREFIX)/lib,LIBDIR = #{CREW_LIB_PREFIX},g' Makefile"
  end

  def self.build
    system "CXXFLAGS='-fuse-ld=mold' CFLAGS='-fuse-ld=mold' make LTO=1"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
