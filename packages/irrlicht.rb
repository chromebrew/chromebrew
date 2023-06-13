require 'package'

class Irrlicht < Package
  description 'An open source realtime 3D engine written in C++ — Libraries and headers'
  homepage 'http://irrlicht.sourceforge.net/'
  version '1.8.5'
  license 'ZLIB'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/irrlicht/irrlicht-1.8.5.zip'
  source_sha256 'effb7beed3985099ce2315a959c639b4973aac8210f61e354475a84105944f3d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/irrlicht/1.8.5_armv7l/irrlicht-1.8.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/irrlicht/1.8.5_armv7l/irrlicht-1.8.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/irrlicht/1.8.5_i686/irrlicht-1.8.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/irrlicht/1.8.5_x86_64/irrlicht-1.8.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6d0e198597e15bb4e9606803abfd3981e259fa4146c9aeb51c407d3b1ef41686',
     armv7l: '6d0e198597e15bb4e9606803abfd3981e259fa4146c9aeb51c407d3b1ef41686',
       i686: '8c1332d73f73efeff230e86250d796a7daf4a8d696f782ba6823cee79f7f3c60',
     x86_64: 'fb72b83979027060249a52e0ec38f0d92e1ae7b04c836230baa744eb967316fd'
  })

  depends_on 'libxrandr'
  depends_on 'libglvnd'
  depends_on 'libxxf86vm'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'dos2unix' => :build
  depends_on 'bz2' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'mesa' # R
  depends_on 'zlibpkg' # R

  def self.patch
    system 'curl -#LO https://dev.gentoo.org/~mgorny/dist/irrlicht-1.8.4-patchset.tar.bz2'
    @sha256sums = <<~EOF
      03b6a5a8a98191f8efe6f7ccd5c957bbf2c4bf15ac6cdc987655792c8baff454  irrlicht-1.8.4-patchset.tar.bz2
    EOF
    File.write('sha256sums', @sha256sums)
    system 'sha256sum -c sha256sums'
    system "sed -i 's:\.\./\.\./media:../media:g' $(grep -rl '\.\./\.\./media' examples)"
    system "sed -i 's/\r$//' source/Irrlicht/COSOperator.cpp"
    system 'dos2unix include/IrrCompileConfig.h'
    system 'tar xvf irrlicht-1.8.4-patchset.tar.bz2'
    system 'for patch in irrlicht-1.8.4-patchset/*; do patch -p 1 -i ${patch}; done'
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
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX.to_s
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/irrlicht"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/libexec/irrlicht"
    FileUtils.cp 'include/*', "#{CREW_DEST_PREFIX}/include/irrlicht"
    FileUtils.cp 'lib/Linux/libIrrlicht.a', CREW_DEST_LIB_PREFIX.to_s
    FileUtils.cp 'lib/Linux/libIrrlicht.so.1.8.5', CREW_DEST_LIB_PREFIX.to_s
    Dir.chdir CREW_DEST_LIB_PREFIX.to_s do
      FileUtils.symlink 'libIrrlicht.so.1.8.5', 'libIrrlicht.so.1.8'
      FileUtils.symlink 'libIrrlicht.so.1.8.5', 'libIrrlicht.so'
    end
  end
end
