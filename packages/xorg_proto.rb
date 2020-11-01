require 'package'

class Xorg_proto < Package
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/'
  version '2020.1'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2020.1.tar.bz2'
  source_sha256 '54a153f139035a376c075845dd058049177212da94d7a9707cf9468367b699d2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2020.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2020.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2020.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2020.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8c99dae5e47ef5735389580f52d19069ab720c7f652ecb92d82a02281c9cfbb9',
     armv7l: '8c99dae5e47ef5735389580f52d19069ab720c7f652ecb92d82a02281c9cfbb9',
       i686: '151dc0b0702a12d98ce943cd674c292580679a83b1419abed6e6f4f0f63b6223',
     x86_64: 'd12a45f902322b2a5dbcf4aa5fffdd08dd8fb71eca4cb850f88237e81d202d21',
  })

  depends_on 'llvm' => ':build'
  
  def self.build
    ENV['CC'] = 'clang'
    ENV['CXX'] = 'clang'
    system "meson #{CREW_MESON_OPTIONS} build"
    system "meson configure build"
    system "ninja -C build"
  end
  
  def self.install
   system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
