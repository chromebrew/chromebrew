# Adapted from Arch Linux squashfuse PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/squashfuse/trunk/PKGBUILD

require 'package'

class Squashfuse < Package
  description 'FUSE filesystem to mount squashfs archives'
  homepage 'https://github.com/vasi/squashfuse'
  version '0.1.104'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/vasi/squashfuse/releases/download/0.1.104/squashfuse-0.1.104.tar.gz'
  source_sha256 'aa52460559e0d0b1753f6b1af5c68cfb777ca5a13913285e93f4f9b7aa894b3a'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/squashfuse/0.1.104_armv7l/squashfuse-0.1.104-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/squashfuse/0.1.104_armv7l/squashfuse-0.1.104-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/squashfuse/0.1.104_i686/squashfuse-0.1.104-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/squashfuse/0.1.104_x86_64/squashfuse-0.1.104-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '83bad067dece48c952a5fd510fdc2f62d4a790d6134f0015eb1c958bb66a4507',
     armv7l: '83bad067dece48c952a5fd510fdc2f62d4a790d6134f0015eb1c958bb66a4507',
       i686: 'afb0d28b2ee43ebc540e6b1d3c4cc56324a3356bd33cea66e47d2ba3797bf5ca',
     x86_64: 'df130e28a509798c98213a139936e6711b7d6d97b2510f3194820cb47e22631d'
  })

  depends_on 'fuse3'
  depends_on 'lzo'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
