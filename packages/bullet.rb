require 'package'

class Bullet < Package
  description '3D Collision Detection and Rigid Body Dynamics Library'
  homepage 'https://pybullet.org/Bullet/phpBB3/'
  version '2.89'
  compatibility 'all'
  source_url 'https://github.com/bulletphysics/bullet3/archive/2.89.tar.gz'
  source_sha256 '621b36e91c0371933f3c2156db22c083383164881d2a6b84636759dc4cbb0bb8'

  depends_on 'libglu'

  def self.build
    FileUtils.mkdir_p "build"
    Dir.chdir 'build' do
    	system "cmake .. -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DINSTALL_LIBDIR=#{CREW_LIB_PREFIX} -DCMAKE_BUILD_TYPE=Release"
    	system "make -j#{CREW_NPROC}"
    end
  end
  def self.install
    Dir.chdir 'build' do
    	system "DESTDIR=#{CREW_DEST_DIR} make install"
    end
  end
end
