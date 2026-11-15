# Adapted from Arch Linux fuse-overlayfs PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/fuse-overlayfs/trunk/PKGBUILD

require 'package'

class Fuse_overlayfs < Package
  description 'FUSE implementation of overlayfs'
  homepage 'https://github.com/containers/fuse-overlayfs'
  version '1.18'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://github.com/containers/fuse-overlayfs.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9501b7c97ab5a6b1ba3a3ab77b5769612abf0a86cd6084ed044d32cf549ef6be',
     armv7l: '9501b7c97ab5a6b1ba3a3ab77b5769612abf0a86cd6084ed044d32cf549ef6be',
       i686: '4779842db8d27feb6de91c1988559adc34121594035ac2c3d9f9441403247f4c',
     x86_64: 'daac13981970ce9f091209f7d9d6a01783f4aa7198f6980f22fd7df62e077c4f'
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
