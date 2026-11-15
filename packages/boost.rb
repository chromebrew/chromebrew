require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'https://www.boost.org/'
  version "1.92.0-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'Boost-1.0'
  compatibility 'all'
  source_url 'https://github.com/boostorg/boost.git'
  git_hashtag "boost-#{version.sub("-#{CREW_ICU_VER}-#{CREW_PY_VER}", '')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ede8ba501aba4b5df4243dc0199b3531467cc185a93fd4feba5cfb3d8d88a99',
     armv7l: '5ede8ba501aba4b5df4243dc0199b3531467cc185a93fd4feba5cfb3d8d88a99',
       i686: 'b125bad2d0819d0723a15aa31b554cbf405a5dec3be8d52403c0b9cef8e129b4',
     x86_64: '35ce5bb362f47e258cd42a1eb40fa65d907363b6ef65e9a20c700ed7616809f5'
  })

  depends_on 'bzip2' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'icu4c' => :library
  depends_on 'openssl' => :library
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
