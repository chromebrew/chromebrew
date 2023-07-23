require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'https://www.boost.org/'
  @_ver = '1.82.0'
  version "#{@_ver}-py3.11"
  license 'Boost-1.0'
  compatibility 'all'
  source_url "https://boostorg.jfrog.io/artifactory/main/release/#{@_ver}/source/boost_#{@_ver.gsub('.', '_')}.tar.bz2"
  source_sha256 'a6e1ab9b0860e6a2881dd7b21fe9f737a095e5f33a3a874afc6a345228597ee6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.82.0-py3.11_armv7l/boost-1.82.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.82.0-py3.11_armv7l/boost-1.82.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.82.0-py3.11_i686/boost-1.82.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.82.0-py3.11_x86_64/boost-1.82.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8650586964ec804d9729b80bedd3ecd07ef065d6af55beb1a810de8857cb1185',
     armv7l: '8650586964ec804d9729b80bedd3ecd07ef065d6af55beb1a810de8857cb1185',
       i686: '1ad00919d0eacbe43012f04b6bb39283616d64023b8a15a017a3a668fc94a0e6',
     x86_64: '909997d7aab071b86c56fb5da8dece3eee7b28497b8a84da901caceabebdb5f2'
  })

  depends_on 'bz2' # R
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
