# Adapted from Arch Linux fuse-overlayfs PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/fuse-overlayfs/trunk/PKGBUILD

require 'package'

class Fuse_overlayfs < Package
  description 'FUSE implementation of overlayfs'
  homepage 'https://github.com/containers/fuse-overlayfs'
  version '1.10'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://github.com/containers/fuse-overlayfs.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse_overlayfs/1.10_armv7l/fuse_overlayfs-1.10-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse_overlayfs/1.10_armv7l/fuse_overlayfs-1.10-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse_overlayfs/1.10_i686/fuse_overlayfs-1.10-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse_overlayfs/1.10_x86_64/fuse_overlayfs-1.10-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '676a073380c10bd30130c76d61a58edace6477bc0762e156645cf0e4749582cd',
     armv7l: '676a073380c10bd30130c76d61a58edace6477bc0762e156645cf0e4749582cd',
       i686: 'fce98a2f2b1bacaaba55baf06f5299c8dfba0d0101126e31f9508ba1a6c2d73b',
     x86_64: 'b87612894c390f30a49be7edc6fd51279acf74bae16535b7d0808435a0252a9c'
  })

  depends_on 'fuse3' # R
  depends_on 'go_md2man' => :build
  depends_on 'glibc' # R

  def self.build
    system 'autoreconf -fiv'
    system "./configure #{CREW_OPTIONS} \
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
