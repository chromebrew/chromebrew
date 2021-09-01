require 'package'

class Libsdl2 < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  @_ver = '2.0.16'
  version @_ver
  license 'ZLIB'
  compatibility 'all'
  source_url "https://www.libsdl.org/release/SDL2-#{@_ver}.tar.gz"
  source_sha256 '65be9ff6004034b5b2ce9927b5a4db1814930f169c4b2dae0a1e4697075f287b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.0.16_armv7l/libsdl2-2.0.16-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.0.16_armv7l/libsdl2-2.0.16-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.0.16_x86_64/libsdl2-2.0.16-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '05cbfc5d3efb7e42009001fea4ade1932f2f273caba7090ab11e68887286ecbd',
     armv7l: '05cbfc5d3efb7e42009001fea4ade1932f2f273caba7090ab11e68887286ecbd',
     x86_64: '5f0d468a5fdf3c5ac02eb3e369af10b975d6e66340e3002289e8c9acd237ef33'
  })

  depends_on 'xorg_server'
  depends_on 'alsa_lib'
  depends_on 'pulseaudio'
  depends_on 'nasm' => :build

  def self.build
    system 'filefix'
    system "env #{CREW_ENV_OPTIONS} \
      ./configure \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
