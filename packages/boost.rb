require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'https://www.boost.org/'
  @_ver = '1.81.0'
  version @_ver
  license 'Boost-1.0'
  compatibility 'all'
  source_url "https://boostorg.jfrog.io/artifactory/main/release/#{@_ver}/source/boost_#{@_ver.gsub('.', '_')}.tar.bz2"
  source_sha256 '71feeed900fbccca04a3b4f2f84a7c217186f28a940ed8b7ed4725986baf99fa'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.81.0_armv7l/boost-1.81.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.81.0_armv7l/boost-1.81.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.81.0_i686/boost-1.81.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.81.0_x86_64/boost-1.81.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '82924d65aba189e489e722951e78826136c272d9aa9ddf1dd904357740652752',
     armv7l: '82924d65aba189e489e722951e78826136c272d9aa9ddf1dd904357740652752',
       i686: 'd025176329c1186d773a4fdfe756c87cf9347ecd74be4fdee622e45a77480ba3',
     x86_64: '44cb11073f0f9bb8cb7b4e4e4f436b12b1d8880e68c51178e9ebfb373fec3cd6'
  })

  depends_on 'bz2' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
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
