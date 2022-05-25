require 'package'

class Bitmap < Package
  description 'bitmap, bmtoa, atobm - X bitmap (XBM) editor and converter utilities'
  homepage 'https://www.x.org'
  version '1.0.9'
  license 'custom'
  compatibility 'all'
  source_url 'https://x.org/archive/individual/app/bitmap-1.0.9.tar.bz2'
  source_sha256 'e0f3afad5272d796f54c33fa1b5bd1fb3f62843a54b28c87196d06a35123e5f5'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bitmap/1.0.9_armv7l/bitmap-1.0.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bitmap/1.0.9_armv7l/bitmap-1.0.9-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bitmap/1.0.9_i686/bitmap-1.0.9-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bitmap/1.0.9_x86_64/bitmap-1.0.9-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '45218cfba754b357f8e0dac9f73b70200a8e10835317e69d20da17ec5d9ca8d0',
     armv7l: '45218cfba754b357f8e0dac9f73b70200a8e10835317e69d20da17ec5d9ca8d0',
       i686: '4d534650ef7d4fa093fba30398684611328586f059bb2f6ae422c09205a087ac',
     x86_64: 'b83e9bd27893924cbde524bf8fb0da3d7055b7ca94b60f51d6f1af2b0002f59c'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
