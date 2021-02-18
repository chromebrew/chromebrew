require 'package'

class Libsdl < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  version '1.2.15-4'
  compatibility 'all'
  source_url 'http://www.libsdl.org/release/SDL-1.2.15.tar.gz'
  source_sha256 'd6d316a793e5e348155f0dd93b979798933fb98aa1edebcc108829d6474aad00'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl-1.2.15-4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl-1.2.15-4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl-1.2.15-4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsdl-1.2.15-4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0875d5715c39505b6c07a04ea267d233df122fb0f2179c09b700b31817e9d4c6',
     armv7l: '0875d5715c39505b6c07a04ea267d233df122fb0f2179c09b700b31817e9d4c6',
       i686: '86e6bfe0051158b63e7b14c5a41d681c759f45522149133031da6854e673bae7',
     x86_64: '1ff00ecd7af2ce401776cbdaa75a8b1d2d7c35d48688124bc986d7f5ef4108da'
  })

  depends_on 'xorg_server'
  depends_on 'alsa_lib'
  depends_on 'pulseaudio'
  depends_on 'mesa'
  depends_on 'nasm' => :build

  def self.patch
    # system "sed -i 's,#ifdef LONG64,#if 0 // Causes a build failure with recent libx11 versions,g' src/video/x11/SDL_x11sym.h"
    patch_description = 'libX11-1.5.99.901 has changed prototype of _XData32'
    patch_url = 'https://github.com/archlinux/svntogit-packages/raw/packages/sdl/trunk/SDL-1.2.15-const_XData32.patch'
    patch_sha256 = 'bab60b515a74b71650ee71d5a0075c77046a7bad48b061673c3798dbdd35446d'
    patch_filename = 'patch'
    puts "Downloading patch: #{patch_description}".yellow
    system('curl', '-s', '--insecure', '-L', '-#', patch_url, '-o', patch_filename)
    abort 'Checksum mismatch. :/ Try again.'.lightred unless
    Digest::SHA256.hexdigest(File.read(patch_filename)) == patch_sha256
    puts 'patch downloaded'.lightgreen
    system 'patch -p 1 < patch'

    system 'filefix'
  end

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
