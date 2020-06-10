require 'package'

class Libxkbfile < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.1.0'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libxkbfile-1.1.0.tar.bz2'
  source_sha256 '758dbdaa20add2db4902df0b1b7c936564b7376c02a0acd1f2a331bd334b38c7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbfile-1.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbfile-1.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbfile-1.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbfile-1.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '667eac3dcdb3e4c79531f3263a5c98696d41650c15bd9b478f80ff77bcbb67f0',
     armv7l: '667eac3dcdb3e4c79531f3263a5c98696d41650c15bd9b478f80ff77bcbb67f0',
       i686: 'c2d5729b30872dcaddd114cca044f91e30fc3a2dcdb9f16f5a4177c99a66dd66',
     x86_64: 'c3e8e8a1c2d34c36ac75eab039ab0eaca01cedd5fe8406a582cc9bdd256fec63',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
