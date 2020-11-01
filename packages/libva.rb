require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (VIdeo Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  version '2.9.0'
  compatibility 'all'
  source_url 'https://github.com/intel/libva/releases/download/2.9.0/libva-2.9.0.tar.bz2'
  source_sha256 'e344c1392dde92696c9ffd9cb3c7277d0a3b912236eb4e0fdedf7f375434584b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3b701a1e42dad0e39971e3ee5c9075285c85f4b3367aa11cff6f0dd217d12f62',
     armv7l: '3b701a1e42dad0e39971e3ee5c9075285c85f4b3367aa11cff6f0dd217d12f62',
       i686: '799062095875bb589996d35d7a1c2d94f8c71507f382213448fbb50e39d01aa4',
     x86_64: 'faa8394f89a8274c1205cf24b6afd42730d46920e16068e24e13ff625f6d3f65',
  })

  depends_on 'llvm'  => ':build'
  depends_on 'libdrm'

  def self.build
    ENV['CC'] = 'clang'
    ENV['CXX'] = 'clang'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
