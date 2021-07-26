require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'https://www.boost.org/'
  @_ver = '1.76.0'
  version @_ver
  license 'Boost-1.0'
  compatibility 'all'
  source_url "https://boostorg.jfrog.io/artifactory/main/release/#{@_ver}/source/boost_#{@_ver.gsub('.','_')}.tar.bz2"
  source_sha256 'f0397ba6e982c4450f27bf32a2a83292aba035b827a5623a14636ea583318c41'

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "#{CREW_ENV_OPTIONS} ./b2 \
            --build-dir=\${PWD}/builddir \
            -a --prefix=#{CREW_DEST_PREFIX} \
            --libdir=#{CREW_DEST_LIB_PREFIX} \
            install"
  end
end
