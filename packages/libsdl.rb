require 'package'

class Libsdl < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  version '1.2.15-3'
  compatibility 'all'
  source_url 'http://www.libsdl.org/release/SDL-1.2.15.tar.gz'
  source_sha256 'd6d316a793e5e348155f0dd93b979798933fb98aa1edebcc108829d6474aad00'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl-1.2.15-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl-1.2.15-3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl-1.2.15-3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl-1.2.15-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd3c4bf0e39075db7dc30b794733682209dec0a0a23df611b73e7f3fffb69f85c',
     armv7l: 'd3c4bf0e39075db7dc30b794733682209dec0a0a23df611b73e7f3fffb69f85c',
       i686: '913282020e94cf12b60f03e67786dacf34378daf848cdc0f52693efa418e154b',
     x86_64: '528be8eff53afff1c1cd7973ecda09fc68adbcbea0c22453764ebf0cb7ce0a59',
  })

  depends_on 'xorg_server'
  depends_on 'alsa_lib'
  depends_on 'pulseaudio'
  depends_on 'mesa'
  depends_on 'nasm' => :build

  def self.patch
    system "sed -i 's,#ifdef LONG64,#if 0 // Causes a build failure with recent libx11 versions,g' src/video/x11/SDL_x11sym.h"
  end

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
