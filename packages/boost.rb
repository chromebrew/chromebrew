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
    aarch64: '57f1cb7e2c26a85afbe422453e7c904c448b04e6f8faf6b4f40f47b650d2f3cc',
     armv7l: '57f1cb7e2c26a85afbe422453e7c904c448b04e6f8faf6b4f40f47b650d2f3cc',
     x86_64: '5720a6f3d8e325c5a413ff4f2b3eaac5909a7a71ebd4631a2321ac24b7fe438b'
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
