require 'package'

class Libsdl2 < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  version '2.0.9'
  source_url 'https://www.libsdl.org/release/SDL2-2.0.9.tar.gz'
  source_sha256 '255186dc676ecd0c1dbf10ec8a2cc5d6869b5079d8a38194c2aecdff54b324b1'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'xwayland'
  depends_on 'alsa_lib'
  depends_on 'pulseaudio'
  depends_on 'nasm' => :build

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
