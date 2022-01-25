# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.0.2'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.0.2_i686/mold-1.0.2-chromeos-i686.tpxz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.0.2_armv7l/mold-1.0.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.0.2_armv7l/mold-1.0.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.0.2_x86_64/mold-1.0.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
       i686: 'ed41e4e4ac350f821d7c0eed871a8970d7b39f4cf0f0c74078de357d3befa11a',
    aarch64: 'e2b5d700b6915c10c677054f2b1e2191111468eaeeb4ac7b5d514382dcedb9c6',
     armv7l: 'e2b5d700b6915c10c677054f2b1e2191111468eaeeb4ac7b5d514382dcedb9c6',
     x86_64: '345bac27ef1f3323e33ad52efb13c9fe83a5cbea228ee882eb7059931bf936bc'
  })

  depends_on 'mimalloc'
  depends_on 'tbb'
  depends_on 'xxhash' => ':build'

  def self.patch
    system "sed -i 's,PREFIX = /usr/local,PREFIX = #{CREW_PREFIX},g' Makefile"
    system "sed -i 's,LIBDIR = \$(PREFIX)/lib,LIBDIR = #{CREW_LIB_PREFIX},g' Makefile"
  end

  def self.build
    system "LTO=1 SYSTEM_MIMALLOC=1 SYSTEM_TBB=1 \
      #{CREW_OPTIONS.sub(/--program-prefix=.*/, '').gsub('--', '')} make #{CREW_ENV_OPTIONS}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
