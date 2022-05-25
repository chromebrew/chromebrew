require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'https://www.boost.org/'
  @_ver = '1.84.0'
  version "#{@_ver}-py3.12"
  license 'Boost-1.0'
  compatibility 'all'
  source_url "https://boostorg.jfrog.io/artifactory/main/release/#{@_ver}/source/boost_#{@_ver.gsub('.', '_')}.tar.bz2"
  source_sha256 'cc4b893acf645c9d4b698e9a0f08ca8846aa5d6c68275c14c3e7949c24109454'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.84.0-py3.12_armv7l/boost-1.84.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.84.0-py3.12_armv7l/boost-1.84.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.84.0-py3.12_i686/boost-1.84.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.84.0-py3.12_x86_64/boost-1.84.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f0861c474039eeec5fcf4c745776db81d7d2566712b6bc28db37f496bb0db4aa',
     armv7l: 'f0861c474039eeec5fcf4c745776db81d7d2566712b6bc28db37f496bb0db4aa',
       i686: 'e7475427878b8b1e2573bc580c95d27f3d8982aaf257a65cce4cfa310f444104',
     x86_64: '47848028e90509037f9bfb0f9996cd1470f6809d12cf07a149d103260d85e295'
  })

  depends_on 'bzip2' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'python3' => :build
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

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
