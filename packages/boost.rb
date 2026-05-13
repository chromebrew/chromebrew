require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'https://www.boost.org/'
  version "1.91.0-1-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'Boost-1.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/boostorg/boost.git'
  git_hashtag "boost-#{version.sub("-#{CREW_ICU_VER}-#{CREW_PY_VER}", '')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '39c96b9675eabae5fbecf9c01a960cd82f62d8d1ef26a0ac956c16f7679962d2',
     armv7l: '39c96b9675eabae5fbecf9c01a960cd82f62d8d1ef26a0ac956c16f7679962d2',
     x86_64: '453e5db93623db95dbf0615a523cf85f360059d27d295242b984ddc3fd4efef0'
  })

  depends_on 'bzip2' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'icu4c' => :library
  depends_on 'python3' => :build
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "./b2 \
            --build-dir=${PWD}/builddir \
            -a --prefix=#{CREW_DEST_PREFIX} \
            --libdir=#{CREW_DEST_LIB_PREFIX} \
            install"
  end
end
