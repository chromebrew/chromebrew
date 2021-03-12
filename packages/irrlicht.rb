require 'package'

class Irrlicht < Package
  description 'An open source realtime 3D engine written in C++ — Libraries and headers'
  homepage 'http://irrlicht.sourceforge.net/'
  version '1.8.4'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/irrlicht/irrlicht-1.8.4.zip'
  source_sha256 'f42b280bc608e545b820206fe2a999c55f290de5c7509a02bdbeeccc1bf9e433'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/irrlicht-1.8.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/irrlicht-1.8.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/irrlicht-1.8.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/irrlicht-1.8.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e98dcd9e79dda539dcc77a4aa5da24fa59f8a465e5f4a42704f2840ad0ddcc9f',
     armv7l: 'e98dcd9e79dda539dcc77a4aa5da24fa59f8a465e5f4a42704f2840ad0ddcc9f',
       i686: '33c6fe1559e924ef6c3ebe75d9bcf5b27d419fe6d31c6989cec84637cd586c93',
     x86_64: 'cad40fccc5ca753ff9d2044bfc720e2d00f775d58691401771eaa731076e4651',
  })
  
  depends_on 'libxrandr'
  depends_on 'libglvnd'
  depends_on 'libxxf86vm'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'dos2unix' => :build
  
  def self.patch
    system "curl -#LO https://dev.gentoo.org/~mgorny/dist/irrlicht-1.8.4-patchset.tar.bz2"
    @sha256sums = <<~EOF
      03b6a5a8a98191f8efe6f7ccd5c957bbf2c4bf15ac6cdc987655792c8baff454  irrlicht-1.8.4-patchset.tar.bz2
    EOF
    IO.write("sha256sums", @sha256sums)
    system "sha256sum -c sha256sums"
    system "sed -i 's:\.\./\.\./media:../media:g' $(grep -rl '\.\./\.\./media' examples)"
    system "sed -i 's/\r$//' source/Irrlicht/COSOperator.cpp"
    system "dos2unix include/IrrCompileConfig.h"
    system "tar xvf irrlicht-1.8.4-patchset.tar.bz2"
    system "for patch in irrlicht-1.8.4-patchset/*; do patch -p 1 -i ${patch}; done"
    system "for m in \$(find -name Makefile); do \
      sed -i 's:-I/usr/include/freetype2/:-I#{CREW_PREFIX}/include/freetype2:g' \$m; \
      sed -i 's:-I/usr/X11R6/include:-I#{CREW_PREFIX}/X11R6/include:g' \$m; \
      sed -i 's:-L/usr/X11R6/lib\$(LIBSELECT):-L/usr/local/X11R6/lib\$(LIBSELECT):g' \$m; \
      sed -i 's:-I/usr/include:-I#{CREW_PREFIX}/include:g' \$m; done"
  end
  
  def self.build
    Dir.chdir 'source/Irrlicht' do
      system 'make sharedlib staticlib'
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/irrlicht"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/libexec/irrlicht"
    FileUtils.cp Dir.glob("include/*"), "#{CREW_DEST_PREFIX}/include/irrlicht"
    FileUtils.cp 'lib/Linux/libIrrlicht.a', "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.cp 'lib/Linux/libIrrlicht.so.1.8.4', "#{CREW_DEST_LIB_PREFIX}"
    Dir.chdir "#{CREW_DEST_LIB_PREFIX}" do
      FileUtils.symlink 'libIrrlicht.so.1.8.4', 'libIrrlicht.so.1.8'
      FileUtils.symlink 'libIrrlicht.so.1.8.4', 'libIrrlicht.so'
    end
  end
end
