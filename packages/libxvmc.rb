require 'package'

class Libxvmc < Package
  description 'X.org X-Video Motion Compensation Library'
  homepage 'https://www.x.org'
  version '1.0.13'
  license 'MIT'
  compatibility 'all'
  source_url "https://gitlab.freedesktop.org/xorg/lib/libxvmc/-/archive/libXvMC-#{version}/libxvmc-libXvMC-#{version}.tar.gz"
  source_sha256 '58a1766176947ec41cf44c917d831db5d619fec11f99637d6deca45458e9829b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxvmc/1.0.13_armv7l/libxvmc-1.0.13-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxvmc/1.0.13_armv7l/libxvmc-1.0.13-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxvmc/1.0.13_i686/libxvmc-1.0.13-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxvmc/1.0.13_x86_64/libxvmc-1.0.13-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fd33a7a2d68eeb1526c3d7e69f57d003f8d94fd0ac4b48e8cf842ec65961e70c',
     armv7l: 'fd33a7a2d68eeb1526c3d7e69f57d003f8d94fd0ac4b48e8cf842ec65961e70c',
       i686: '4495ace012bc8611229c72ea0c0dbf49b7888cfecadd37dfbd7517cb12bf890f',
     x86_64: '47ce9336e23acf5f44f06501a411a8e79a853b41c746f2fc368f55b0903130fc'
  })

  depends_on 'libxv'
  depends_on 'libx11'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
            builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
