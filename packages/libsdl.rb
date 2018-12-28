require 'package'

class Libsdl < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  version '1.2.15-2'
  source_url 'http://www.libsdl.org/release/SDL-1.2.15.tar.gz'
  source_sha256 'd6d316a793e5e348155f0dd93b979798933fb98aa1edebcc108829d6474aad00'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl-1.2.15-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl-1.2.15-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl-1.2.15-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl-1.2.15-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dd572e285fc4485ec46c36f7612f06f78ee2565e4fa5814c2828c520ea7f44ac',
     armv7l: 'dd572e285fc4485ec46c36f7612f06f78ee2565e4fa5814c2828c520ea7f44ac',
       i686: '485362d999a6a6ab466c8a544df175b9e93db2b5149ee0f37be4bf33d6adc66b',
     x86_64: 'f9c9cee413c6acd449fefadb44f8148595124d994b658fedca67642921369b43',
  })

  depends_on 'dbus'
  depends_on 'eudev'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-video-wayland',
           '--disable-video-x11'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
