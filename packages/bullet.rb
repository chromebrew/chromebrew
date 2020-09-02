require 'package'

class Bullet < Package
  description '3D Collision Detection and Rigid Body Dynamics Library'
  homepage 'https://pybullet.org/Bullet/phpBB3/'
  version '2.89'
  compatibility 'all'
  source_url 'https://github.com/bulletphysics/bullet3/archive/2.89.tar.gz'
  source_sha256 '621b36e91c0371933f3c2156db22c083383164881d2a6b84636759dc4cbb0bb8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bullet-2.89-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bullet-2.89-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bullet-2.89-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bullet-2.89-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'de8d4c188438087d438173aa33cea512deadc88e1c3f94cd6b9932c389b46d47',
     armv7l: 'de8d4c188438087d438173aa33cea512deadc88e1c3f94cd6b9932c389b46d47',
       i686: 'ca1b96c780d198f1f9106a2737a03a75b5518abb89d8894a77ba7fef44866032',
     x86_64: 'a864c0d9f5429c0a5bff7e4a38b5367820ca3bf110f9baacff5b3b5306114b09',
  })

  depends_on 'bdftopcf'
  depends_on 'libglu'
  depends_on 'openvr'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake .. -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DLIB_DESTINATION=#{ARCH_LIB} -DCMAKE_BUILD_TYPE=Release"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "DESTDIR=#{CREW_DEST_DIR} make install"
    end
  end
end
