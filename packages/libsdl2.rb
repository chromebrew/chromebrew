require 'package'

class Libsdl2 < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  version '2.0.9'
  compatibility 'all'
  source_url 'https://www.libsdl.org/release/SDL2-2.0.9.tar.gz'
  source_sha256 '255186dc676ecd0c1dbf10ec8a2cc5d6869b5079d8a38194c2aecdff54b324b1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl2-2.0.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl2-2.0.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl2-2.0.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl2-2.0.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8d317956cc1a196d8f5d1a84993abda2c04091afabf71ade3229f9077082b99f',
     armv7l: '8d317956cc1a196d8f5d1a84993abda2c04091afabf71ade3229f9077082b99f',
       i686: 'd1a410a9aa771feb91da30f7cab69a38aa88b8cb3a18a16653c30f4b4f9ae6da',
     x86_64: '4a7cf8e0c57bb8485eb1cade392ca919aff3e71b811464adf6a51e1f98488a00',
  })

  depends_on 'xorg_server'
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
