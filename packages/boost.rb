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
    aarch64: '1113d598a51433e3af13f16e9f8ca7fc455dc3ad9bcfb70e21eabf5ba9563a4c',
     armv7l: '1113d598a51433e3af13f16e9f8ca7fc455dc3ad9bcfb70e21eabf5ba9563a4c',
       i686: '45c0c75599411ae57bfc70a0c66f875c8b55a3b8ea75384c8904c12c5904279e',
     x86_64: '435ea4db8b2284810868e3c014262602f037f9e6e5cc2ffea5d21d0be99e9856'
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
