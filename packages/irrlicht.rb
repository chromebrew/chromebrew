require 'package'

class Irrlicht < Package
  description 'An open source realtime 3D engine written in C++.'
  homepage 'http://irrlicht.sourceforge.net/'
  version '1.8.4'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/irrlicht/irrlicht-1.8.4.zip'
  source_sha256 'f42b280bc608e545b820206fe2a999c55f290de5c7509a02bdbeeccc1bf9e433'
  
  depends_on 'libxrandr'
  depends_on 'libglvnd'
  depends_on 'libxxf86vm'
  depends_on 'libjpeg'
  depends_on 'libpng'
  
  def self.build
    Dir.chdir 'source/Irrlicht' do
      system 'make'
      system 'make clean'
      system 'make sharedlib'
    end
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/irrlicht"
    FileUtils.cp Dir.glob("include/*"), "#{CREW_DEST_PREFIX}/include/irrlicht"
    FileUtils.cp 'lib/Linux/libIrrlicht.a', CREW_DEST_LIB_PREFIX
    FileUtils.cp 'lib/Linux/libIrrlicht.so.1.8.4', CREW_DEST_LIB_PREFIX
    Dir.chdir CREW_DEST_LIB_PREFIX do
      FileUtils.symlink 'libIrrlicht.so.1.8.4', 'libIrrlicht.so.1'
      FileUtils.symlink 'libIrrlicht.so.1.8.4', 'libIrrlicht.so'
    end
  end
end
