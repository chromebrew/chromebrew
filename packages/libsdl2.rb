require 'package'

class Libsdl2 < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  @_ver = '2.0.18'
  version @_ver
  license 'ZLIB'
  compatibility 'all'
  source_url 'https://github.com/libsdl-org/SDL.git'
  git_hashtag "release-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.0.16_armv7l/libsdl2-2.0.16-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.0.16_armv7l/libsdl2-2.0.16-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.0.18_i686/libsdl2-2.0.18-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.0.18_x86_64/libsdl2-2.0.18-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '05cbfc5d3efb7e42009001fea4ade1932f2f273caba7090ab11e68887286ecbd',
     armv7l: '05cbfc5d3efb7e42009001fea4ade1932f2f273caba7090ab11e68887286ecbd',
    i686: '3089c520dfce88e2c878bbc28135feb39af7fd05e681772011fd429137ff9d07',
  x86_64: '8c3d271c3440af75ea3cbefa84508878808177090683acd1d07e38d54d56e987'
  })

  depends_on 'xorg_server'
  depends_on 'alsa_lib'
  depends_on 'ibus'
  depends_on 'pulseaudio'
  depends_on 'nasm' => :build

  def self.patch
    system 'filefix'
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} \
      ./configure \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
