# Adapted from Arch Linux mujs PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mujs/trunk/PKGBUILD

require 'package'

class Mujs < Package
  description 'An embeddable Javascript interpreter in C'
  homepage 'https://mujs.com/'
  version '1.1.0'
  license 'ISC'
  compatibility 'all'
  source_url "https://github.com/ccxvii/mujs/archive/refs/tags/#{version}.tar.gz"
  source_sha256 '8e43a38fdea75f036a9f3213e346a6c304206b4e3d00886564fb6bf70c1c2807'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mujs/1.1.0_armv7l/mujs-1.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mujs/1.1.0_armv7l/mujs-1.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mujs/1.1.0_i686/mujs-1.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mujs/1.1.0_x86_64/mujs-1.1.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6e35d13ccbbf048b85406b5edf5a9ff1965359bcace8a7c53ca9a293691bc09c',
     armv7l: '6e35d13ccbbf048b85406b5edf5a9ff1965359bcace8a7c53ca9a293691bc09c',
       i686: '164594e24f4fe2cf051593ab8d8f1d540c0ed3b2322b8a29ce223fec56837b8a',
     x86_64: '016d3bcc9608929db4bcb55b7449151200557c4407187a1f6cd806cfdd8a42ad'
  })

  def self.build
    system "env XCFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      XCPPFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      make prefix=release shared"
  end

  def self.install
    system "make \
      DESTDIR=#{CREW_DEST_DIR} \
      prefix=#{CREW_PREFIX} \
      libdir=#{CREW_LIB_PREFIX} \
      install-shared"
  end
end
