# Adapted from Arch Linux fuse-overlayfs PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/fuse-overlayfs/trunk/PKGBUILD

require 'package'

class Fuse_overlayfs < Package
  description 'FUSE implementation of overlayfs'
  homepage 'https://github.com/containers/fuse-overlayfs'
  version '1.8.2'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://github.com/containers/fuse-overlayfs.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse_overlayfs/1.8.2_armv7l/fuse_overlayfs-1.8.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse_overlayfs/1.8.2_armv7l/fuse_overlayfs-1.8.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse_overlayfs/1.8.2_i686/fuse_overlayfs-1.8.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse_overlayfs/1.8.2_x86_64/fuse_overlayfs-1.8.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '743fab0fb1b5b0870bcf6b039e4584864f29e3515feb9c7d8e1452933d053db8',
     armv7l: '743fab0fb1b5b0870bcf6b039e4584864f29e3515feb9c7d8e1452933d053db8',
       i686: 'd9202201b363ab5f15999622c853a246f218d73a842c5d2bfd8c9017784bee7f',
     x86_64: '88862153fb47b449e2689208068fd41f18e2bb516330a4bc78775a40f5ac1394'
  })

  depends_on 'fuse3'
  depends_on 'go_md2man' => :build

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
