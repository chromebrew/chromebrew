# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.3.0'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.3.0_armv7l/mold-1.3.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.3.0_armv7l/mold-1.3.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.3.0_i686/mold-1.3.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.3.0_x86_64/mold-1.3.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3258e2b7137f5f5abd65a65c468684d2031d54ba9528f28300b4eae4762e43d8',
     armv7l: '3258e2b7137f5f5abd65a65c468684d2031d54ba9528f28300b4eae4762e43d8',
       i686: '2c4979b2b78dc26174d67abce50de41d229c301397ee0f4ca05f23548f1fe15e',
     x86_64: '78e055e34e2872acba9cb85f1d9d59c9e165c861cae78593b933dfa6616aa182'
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
