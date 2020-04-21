require 'package'

class Qhull < Package
  description 'Qhull computes the convex hull, Delaunay triangulation, Voronoi diagram, halfspace intersection about a point, furthest-site Delaunay triangulation, and furthest-site Voronoi diagram.'
  homepage 'http://www.qhull.org/'
  version '7.3.2'
  source_url 'http://www.qhull.org/download/qhull-2019-src-7.3.2.tgz'
  source_sha256 '2b7990558c363076261564f61b74db4d0d73b71869755108a469038c07dc43fb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qhull-7.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qhull-7.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qhull-7.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qhull-7.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7bc54fddbe41b66894fa2c713145af000e85e761f4dbd3198ceea3d2fe2760d3',
     armv7l: '7bc54fddbe41b66894fa2c713145af000e85e761f4dbd3198ceea3d2fe2760d3',
       i686: '50e78beea512b3784524e7c3d844c14fb4ec5c08a0b76e61561336249c07ae22',
     x86_64: '725d91947d86ef4b70977b56770d78284fadd6b1de54042da95e885aa5b6f215',
  })

  def self.build
    Dir.chdir 'build' do
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '..'
      system 'make'
    end
  end

  def self.check
    Dir.chdir 'build' do
      system 'ctest'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      if ARCH == 'x86_64'
        FileUtils.mkdir CREW_DEST_LIB_PREFIX
        FileUtils.mv Dir.glob("#{CREW_DEST_PREFIX}/lib/*"), CREW_DEST_LIB_PREFIX
      end
    end
  end
end
