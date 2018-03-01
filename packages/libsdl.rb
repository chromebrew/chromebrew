require 'package'

class Libsdl < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  version '1.2.15-1'
  source_url 'http://www.libsdl.org/release/SDL-1.2.15.tar.gz'
  source_sha256 'd6d316a793e5e348155f0dd93b979798933fb98aa1edebcc108829d6474aad00'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl-1.2.15-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl-1.2.15-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl-1.2.15-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl-1.2.15-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7243fc79a7734a63ce5a6496dc1a6a7b2a9f22c2f8e96f7ec7ec437144835cd6',
     armv7l: '7243fc79a7734a63ce5a6496dc1a6a7b2a9f22c2f8e96f7ec7ec437144835cd6',
       i686: 'da4d8372f7954e9da9c02734af6dbb5238917fcc0b1e5b08803f807a0683ab27',
     x86_64: '0237c7da8ab2f5f636881bfbe7a858799b2bb05d8e26ff411305680ac69aba29',
  })

  def self.build
    system "./configure --disable-video-x11 --disable-video-wayland"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
