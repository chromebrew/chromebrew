require 'package'

class Libsdl2 < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  @_ver = '2.0.14'
  version @_ver
  compatibility 'all'
  source_url "https://www.libsdl.org/release/SDL2-#{@_ver}.tar.gz"
  source_sha256 'd8215b571a581be1332d2106f8036fcb03d12a70bae01e20f424976d275432bc'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl2-2.0.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl2-2.0.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl2-2.0.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl2-2.0.14-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '824f086a8e1fbe7fc90e9d715f402bfe77cf4800574be2bc8404cc3d1b73803f',
     armv7l: '824f086a8e1fbe7fc90e9d715f402bfe77cf4800574be2bc8404cc3d1b73803f',
       i686: '7952f95341bbac68414e6d2edacda191061e6dc203e41350e11e116feb313ff9',
     x86_64: 'bdf479e4bb1f8898bd59ffc09fdffb4861a49294e849bfa49ef207fa38a66061'
  })

  depends_on 'xorg_server'
  depends_on 'alsa_lib'
  depends_on 'pulseaudio'
  depends_on 'nasm' => :build

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
