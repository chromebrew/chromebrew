# Adapted from Arch Linux fuse-overlayfs PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/fuse-overlayfs/trunk/PKGBUILD

require 'package'

class Fuse_overlayfs < Package
  description 'FUSE implementation of overlayfs'
  homepage 'https://github.com/containers/fuse-overlayfs'
  version '1.17'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://github.com/containers/fuse-overlayfs.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ce5dfbea26f897d4501a9e9c521b54024c86b8298f693fb90fa11993e73dc2c',
     armv7l: '2ce5dfbea26f897d4501a9e9c521b54024c86b8298f693fb90fa11993e73dc2c',
       i686: '4be4f595c07ad9d5d8e9258482472acc5e44d91df033c4b856f5d8947c8248e7',
     x86_64: '3c4b8501e7ea560cba2a024c45557b7cdc0f38e1a45e2a8a0c69c9f296e2326e'
  })

  depends_on 'fuse3' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go_md2man' => :build

  def self.build
    system 'autoreconf -fiv'
    system "./configure #{CREW_CONFIGURE_OPTIONS} \
      --sbindir=#{CREW_PREFIX}/bin"
    system 'make'
  end

  def self.check
    system 'make check'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
