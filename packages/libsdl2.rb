require 'package'

class Libsdl2 < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  version '2.0.8'
  source_url 'https://www.libsdl.org/release/SDL2-2.0.8.tar.gz'
  source_sha256 'edc77c57308661d576e843344d8638e025a7818bff73f8fbfab09c3c5fd092ec'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl2-2.0.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl2-2.0.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl2-2.0.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl2-2.0.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8d72ba834b2b3134f31b48f50febba28063da56f1e4dea97baffe1eca55b337d',
     armv7l: '8d72ba834b2b3134f31b48f50febba28063da56f1e4dea97baffe1eca55b337d',
       i686: '1c54d9a41d86ceeb78fa6b2f688ae886d5aa00c694e30cce173bd5ec8444195f',
     x86_64: 'c771bddb8be9b2637978593a013f880f6faeea651d93c66fdb92f38c30100580',
  })

  depends_on 'dbus'
  depends_on 'eudev'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-video-wayland',
           '--disable-video-x11'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
