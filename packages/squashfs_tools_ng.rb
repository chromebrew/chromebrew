# Adapted from Arch Linux squashfs-tools-ng PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=squashfs-tools-ng

require 'package'

class Squashfs_tools_ng < Package
  description 'A new set of tools and libraries for working with SquashFS images'
  homepage 'https://infraroot.at/projects/squashfs-tools-ng/index.html'
  version '1.1.0'
  license 'GPLv3'
  compatibility 'all'
  source_url 'https://infraroot.at/pub/squashfs/squashfs-tools-ng-1.1.0.tar.xz'
  source_sha256 '110794124b268e92e28e6a95f0781d1338f48c338434ef746f5de68c64e19aeb'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '60048d2dd13cc62c08437afd9ef009977d4d40e5ebd3bb8e60dc8a1de0766b2f',
     armv7l: '60048d2dd13cc62c08437afd9ef009977d4d40e5ebd3bb8e60dc8a1de0766b2f',
       i686: '92926e16bd5f9607e35e1b0ef3b3d10ad6a2d9e6b2cedc19cbd431f1f881c4ff',
     x86_64: '5a3c9173fe96e8f9f3a0e0a6f764c4f88e0871c10140a7d2caf966a9956687c4'
  })

  depends_on 'lzo'

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-pipe -flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
    system 'make doxygen-doc'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
