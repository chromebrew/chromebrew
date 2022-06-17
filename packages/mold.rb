# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.2.1-d8a8877'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag 'd8a8877875d96d0efdb727b4ba600ee3910a333f'


  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.2.1-d8a8877_armv7l/mold-1.2.1-d8a8877-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.2.1-d8a8877_armv7l/mold-1.2.1-d8a8877-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.2.1-d8a8877_i686/mold-1.2.1-d8a8877-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.2.1-d8a8877_x86_64/mold-1.2.1-d8a8877-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3d79cc7d4283e165e469b5e9f3c38ce7528e6f0e04c5a3cddc6443ea32c41fd4',
     armv7l: '3d79cc7d4283e165e469b5e9f3c38ce7528e6f0e04c5a3cddc6443ea32c41fd4',
       i686: '6acb72f499175a5a42f9ff14df89631009277de3fcfdaebb62a22b3d338a2c9e',
     x86_64: 'a6beb44615308b7747999fc7856e30c493c4c4faadf5d25b03bd5cb32852fddb'
  })

  depends_on 'zlibpkg' # R
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
