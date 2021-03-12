require 'package'

class Irrlicht_examples < Package
  description 'An open source realtime 3D engine written in C++ — Examples'
  homepage 'http://irrlicht.sourceforge.net/'
  version '1.8.4'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/irrlicht/irrlicht-1.8.4.zip'
  source_sha256 'f42b280bc608e545b820206fe2a999c55f290de5c7509a02bdbeeccc1bf9e433'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/irrlicht_examples-1.8.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/irrlicht_examples-1.8.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/irrlicht_examples-1.8.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/irrlicht_examples-1.8.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '016e609af12216dbb79dded23cf223d668eefbee5c33087921ac9a2faf99fddb',
     armv7l: '016e609af12216dbb79dded23cf223d668eefbee5c33087921ac9a2faf99fddb',
       i686: '8653b1d919a602d0269484daec98047d0e4b5e655b50bae8d49341b04b4a0e2e',
     x86_64: '6c366e0e444594fe94ef29cf6bcf309940d1a3daa2e0c0f151329e73fc142990',
  })
  
  depends_on 'irrlicht'
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
    Dir.chdir 'examples' do
      system 'make'
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/libexec/irrlicht/examples"
    Dir.chdir 'bin' do
      FileUtils.cp Dir.glob("Linux/*"), '.'
      FileUtils.rm_r Dir.glob("Win*")
      FileUtils.rm_r "MacOSX"
      FileUtils.rm_r "Linux"
      FileUtils.rm "readme.txt"
      FileUtils.cp Dir.glob("./*"), "#{CREW_DEST_PREFIX}/libexec/irrlicht/examples/"
    end
  end
end
