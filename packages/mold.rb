# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.4.1'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.1_armv7l/mold-1.4.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.1_armv7l/mold-1.4.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.1_i686/mold-1.4.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.1_x86_64/mold-1.4.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c0a7e8aef0e1819104f611c083aae26e0eb5d5905cad61c0043d7db85e85c695',
     armv7l: 'c0a7e8aef0e1819104f611c083aae26e0eb5d5905cad61c0043d7db85e85c695',
       i686: '5b9f9ba38052b8486c9890b6276315e1ba9ef7785f4434b3b5da4723bec7453a',
     x86_64: '15f7b7f2b3fc95213d28bdf301d32cff22ff77becb3ca60e9e0c21dc1f547dca'
  })

  depends_on 'zlibpkg' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'gcc' # R
  depends_on 'xxhash' => :build
  no_env_options

  def self.patch
    system "sed -i 's,PREFIX = /usr/local,PREFIX = #{CREW_PREFIX},g' Makefile"
    system "sed -i 's,/usr/bin/python3,#{CREW_PREFIX}/bin/python3,g' update-git-hash.py"
    system "sed -i 's,LIBDIR = \$(PREFIX)/lib,LIBDIR = #{CREW_LIB_PREFIX},g' Makefile"
  end

  def self.build
    system "CXXFLAGS='-fuse-ld=mold' CFLAGS='-fuse-ld=mold' make LTO=1"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
