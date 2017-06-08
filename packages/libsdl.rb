require 'package'

class Libsdl < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org/'
  version '1.2.15'
  source_url 'http://www.libsdl.org/release/SDL-1.2.15.tar.gz'
  source_sha1 '0c5f193ced810b0d7ce3ab06d808cbb5eef03a2c'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
