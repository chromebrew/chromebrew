require 'package'

class Babl < Package
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'http://gegl.org/babl/'
  version '0.1.86'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://download.gimp.org/pub/babl/0.1/babl-0.1.86.tar.xz'
  source_sha256 '0b3f595159ad1b216cd729c0504c3a5f6cf780c641f4dc63fc164f3c0382c8f0'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/babl-0.1.86-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/babl-0.1.86-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/babl-0.1.86-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/babl-0.1.86-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b3eea8151c169644a29b812cf4c8c3e7bb686c21d2fe5b41b9e0d0b334010ebf',
     armv7l: 'b3eea8151c169644a29b812cf4c8c3e7bb686c21d2fe5b41b9e0d0b334010ebf',
       i686: '93e0a006b2c8c0ab5b2ff168bc7cbedc1b8da405c7875039a985b3e3b2ecafde',
     x86_64: 'e81d6eb3d33030d6414cdb2c028794ae87e6cd945df4a546b4b172f39ec232e6'
  })

  depends_on 'lcms'
  depends_on 'pango'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.check
    system 'ninja -C builddir test || true'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
