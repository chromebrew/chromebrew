require 'package'

class Libxrandr < Package
  description 'X.org X Resize, Rotate and Reflection extension library'
  homepage 'http://www.x.org'
  version '1.5.1-0'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXrandr-1.5.1.tar.gz'
  source_sha256 '2baa7fb3eca78fe7e11a09b373ba898b717f7eeba4a4bfd68187e04b4789b0d3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxrandr-1.5.1-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxrandr-1.5.1-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxrandr-1.5.1-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxrandr-1.5.1-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e5c828eb0ab26b68b7e3dccbb8d786267230584cbf8f33593796e20349895147',
     armv7l: 'e5c828eb0ab26b68b7e3dccbb8d786267230584cbf8f33593796e20349895147',
       i686: 'a488a6f27c2670310d7f144409a5657d8271e42a23f0bc578112615c706f16a0',
     x86_64: '6a37502061445761f860acefaddd5bf06b7c64b4b5e468f4e3902e67baaef05e',
  })

  depends_on 'libxrender'
  depends_on 'libx11'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
