require 'package'

class Libsdl2 < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  version '2.0.7'
  source_url 'https://www.libsdl.org/release/SDL2-2.0.7.tar.gz'
  source_sha256 'ee35c74c4313e2eda104b14b1b86f7db84a04eeab9430d56e001cea268bf4d5e'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --disable-video-x11 --disable-video-wayland"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
