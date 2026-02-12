# Adapted from Arch Linux fuse-overlayfs PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/fuse-overlayfs/trunk/PKGBUILD

require 'package'

class Fuse_overlayfs < Package
  description 'FUSE implementation of overlayfs'
  homepage 'https://github.com/containers/fuse-overlayfs'
  version '1.16'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://github.com/containers/fuse-overlayfs.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f5f34e8005324799c5dd3e6e9287c92f549c6751bc956f1c226a41b98ff3c717',
     armv7l: 'f5f34e8005324799c5dd3e6e9287c92f549c6751bc956f1c226a41b98ff3c717',
       i686: '47c5e67a8066685d834b918c64d62f84cfec1a5519ca355ea397e623f9982dfe',
     x86_64: '7d6f6ff5fdcd81f2cf3b2ca91811a23baa4c4aaab25de136bc51fe80d961f6fa'
  })

  depends_on 'fuse3' # R
  depends_on 'glibc' # R
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
