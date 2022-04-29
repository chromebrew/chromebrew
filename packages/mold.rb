# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.2.1'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.2.1_armv7l/mold-1.2.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.2.1_armv7l/mold-1.2.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.2.1_i686/mold-1.2.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.2.1_x86_64/mold-1.2.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c5d2cb41de614fd6348195619e6f6132e1382ab08a3ef914b90b640fab48d2ac',
     armv7l: 'c5d2cb41de614fd6348195619e6f6132e1382ab08a3ef914b90b640fab48d2ac',
       i686: '659f6da41b604fcc900c70e5805209b1ac0b3b8d3e026c719f0d57f222944e8d',
     x86_64: '7cd47648337aacc6f8b137693b2626bff44649b5ba4c0422f9a9fadc27504150'
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
