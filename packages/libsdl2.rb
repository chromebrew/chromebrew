require 'package'

class Libsdl2 < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  @_ver = '2.0.20'
  version @_ver
  license 'ZLIB'
  compatibility 'all'
  source_url 'https://github.com/libsdl-org/SDL.git'
  git_hashtag "release-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.0.20_armv7l/libsdl2-2.0.20-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.0.20_armv7l/libsdl2-2.0.20-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.0.20_i686/libsdl2-2.0.20-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.0.20_x86_64/libsdl2-2.0.20-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd52290a1e8cc8c7922ca91a9d95df39b6ab65f4a0eca007347b7205203530337',
     armv7l: 'd52290a1e8cc8c7922ca91a9d95df39b6ab65f4a0eca007347b7205203530337',
       i686: '61782729b7ceec09e2239aabbdcde7ea1dc3d7f47332db3cdd20fca815cac2b0',
     x86_64: '3ab3b5cd9beeb10b10e2216f937a5e31405599ff134ceffa6619a33fe9636c8e'
  })

  depends_on 'xorg_server'
  depends_on 'alsa_lib'
  depends_on 'ibus'
  depends_on 'pulseaudio'
  depends_on 'nasm' => :build
  patchelf

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
