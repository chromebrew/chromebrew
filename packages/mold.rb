# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.1.1'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.1.1_armv7l/mold-1.1.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.1.1_armv7l/mold-1.1.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.1.1_i686/mold-1.1.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.1.1_x86_64/mold-1.1.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'af8d0ad4094a02d26508da23af2e8b000f40c982c3d4ee43e25b42806d139dbe',
     armv7l: 'af8d0ad4094a02d26508da23af2e8b000f40c982c3d4ee43e25b42806d139dbe',
       i686: '966053e7967f58f131d03d213f1e0f26d969a6d7296b90b78e245f471af5b34d',
     x86_64: '622f44f74252163a17a418bdb7efe42c3a59d1956790260666268f462a3b8930'
  })

  depends_on 'xxhash' => :build
  no_env_options

  def self.patch
    system "sed -i 's,PREFIX = /usr/local,PREFIX = #{CREW_PREFIX},g' Makefile"
    system "sed -i 's,LIBDIR = \$(PREFIX)/lib,LIBDIR = #{CREW_LIB_PREFIX},g' Makefile"
  end

  def self.build
    system 'make LTO=1'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
