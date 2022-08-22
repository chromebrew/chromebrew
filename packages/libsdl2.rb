require 'package'

class Libsdl2 < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  @_ver = '2.24.0'
  version @_ver
  license 'ZLIB'
  compatibility 'all'
  source_url 'https://github.com/libsdl-org/SDL.git'
  git_hashtag "release-#{@_ver}"

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.24.0_i686/libsdl2-2.24.0-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.24.0_x86_64/libsdl2-2.24.0-chromeos-x86_64.tar.zst',
 aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.24.0_armv7l/libsdl2-2.24.0-chromeos-armv7l.tar.zst',
  armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.24.0_armv7l/libsdl2-2.24.0-chromeos-armv7l.tar.zst'
  })
  binary_sha256({
    i686: '1bd6297e4988229ce177a37f49985356610fc30d6f853a0b3bd8375ddbf67b61',
  x86_64: '9a93f85dc4c8889b48c32ed9755367e67df2bceb0c200a59bc25f8d85a51d83f',
 aarch64: '359f785c46faa39300fcdca8a52f9b35a3cbc143cf02d88d0a7aacb0b7df068e',
  armv7l: '359f785c46faa39300fcdca8a52f9b35a3cbc143cf02d88d0a7aacb0b7df068e'
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
