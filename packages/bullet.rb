require 'buildsystems/cmake'

class Bullet < CMake
  description '3D Collision Detection and Rigid Body Dynamics Library'
  homepage 'https://pybullet.org/Bullet/phpBB3/'
  version '3.25'
  license 'ZLIB'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/bulletphysics/bullet3/archive/#{version}.tar.gz"
  source_sha256 'c45afb6399e3f68036ddb641c6bf6f552bf332d5ab6be62f7e6c54eda05ceb77'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bb49e18b6f578154267f8d1a6979793225fecf2b6f9bd02afe1af2f75cf53cd8',
     armv7l: 'bb49e18b6f578154267f8d1a6979793225fecf2b6f9bd02afe1af2f75cf53cd8',
     x86_64: '94d80568223ebc79a74d8485d8e7e88155d3332854dc996f77b710e9febac61e'
  })

  depends_on 'bdftopcf' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libglu' => :library
  depends_on 'openvr' => :library

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DBUILD_SHARED_LIBS=ON -DBUILD_PYBULLET=ON \
    -DCLSOCKET_SHARED=ON -DINSTALL_LIBS=ON -DUSE_DOUBLE_PRECISION=ON -DUSE_OPENVR=ON'

  cmake_install_extras do
    if ARCH.eql?('x86_64')
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX.to_s
      FileUtils.mv Dir["#{CREW_DEST_PREFIX}/lib/*"], CREW_DEST_LIB_PREFIX.to_s
    end
  end
end
