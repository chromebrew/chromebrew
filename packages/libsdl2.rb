require 'package'

class Libsdl2 < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  @_ver = '2.0.22'
  version @_ver
  license 'ZLIB'
  compatibility 'all'
  source_url 'https://github.com/libsdl-org/SDL.git'
  git_hashtag "release-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.0.22_armv7l/libsdl2-2.0.22-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.0.22_armv7l/libsdl2-2.0.22-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.0.22_i686/libsdl2-2.0.22-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.0.22_x86_64/libsdl2-2.0.22-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f4da387182a750ffd0217770492f2726e98b5bf10610e73cdf19264b1c133509',
     armv7l: 'f4da387182a750ffd0217770492f2726e98b5bf10610e73cdf19264b1c133509',
       i686: '53ee765821d142fe2b0c9f8af8dd1529466977a4229964c0c2c7c22c94ec00e8',
     x86_64: '9d6abfe61dae7446d32c9500d9f8764dff8f1a89af5029bbbf4b83acf7b582d1'
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
