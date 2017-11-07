require 'package'

class Libsdl2 < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  version '2.0.5-1'
  source_url 'https://www.libsdl.org/release/SDL2-2.0.5.tar.gz'
  source_sha256 '442038cf55965969f2ff06d976031813de643af9c9edc9e331bd761c242e8785'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl2-2.0.5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl2-2.0.5-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl2-2.0.5-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl2-2.0.5-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '79597d7b228ebb8929ceef776032226f9fa9d70672f40b421447b964469da2f0',
     armv7l: '79597d7b228ebb8929ceef776032226f9fa9d70672f40b421447b964469da2f0',
       i686: 'b242dc03f077e0758336956bcc28e935773f75cca0720d047d1d8f3be94cb8c3',
     x86_64: '84d257d6f385e4535f8643d6dc0c5dc455fa197705ff17e058024822f0fe7f86',
  })

  def self.build
    system "./configure --disable-video-x11 --disable-video-wayland"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
