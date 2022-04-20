# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.2.0'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.2.0_armv7l/mold-1.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.2.0_armv7l/mold-1.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.2.0_i686/mold-1.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.2.0_x86_64/mold-1.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1d006972a44a96820a1f75bf84cb48332380d607672b9d9ae4ae293811b615eb',
     armv7l: '1d006972a44a96820a1f75bf84cb48332380d607672b9d9ae4ae293811b615eb',
       i686: '766197f6e67e22f7bd7ae2d67cf5f54d13cbee85827a9cf67b41b3e72da02bef',
     x86_64: 'c0969ca649aedd3a4f30a0a62263a40c3e6d0064eb6ced1539c0a9544babfc73'
  })

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
