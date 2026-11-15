require 'buildsystems/cmake'

class Qhull < CMake
  description 'Qhull computes the convex hull, Delaunay triangulation, Voronoi diagram, halfspace intersection about a point, furthest-site Delaunay triangulation, and furthest-site Voronoi diagram.'
  homepage 'http://www.qhull.org/'
  version '8.0.2'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/qhull/qhull.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd5923237e3976fef5545db839b2dfcd090a9ca2e299e0cc3e2cbae14af5ee894',
     armv7l: 'd5923237e3976fef5545db839b2dfcd090a9ca2e299e0cc3e2cbae14af5ee894',
       i686: 'c2665bfbcf05722e56d2c3c6907a22aea08a3473162a79164cb4eb72c7d74a12',
     x86_64: '015344b1955d0dce18e0c77769e3a82f51ec3af9f0ea6dc853bf70ddc091f80b'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'

  cmake_install_extras do
    # No cmake LIB_INSTALL_DIR option for x86_64.
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib", CREW_DEST_LIB_PREFIX if ARCH.eql?('x86_64')
  end
end
