require 'package'

class Libsdl2 < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  version '2.0.5'
  source_url 'https://www.libsdl.org/release/SDL2-2.0.5.tar.gz'
  source_sha256 '442038cf55965969f2ff06d976031813de643af9c9edc9e331bd761c242e8785'

  def self.build
    system "./configure --disable-video-x11 --disable-video-wayland"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
