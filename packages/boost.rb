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

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.76.0_armv7l/boost-1.76.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.76.0_armv7l/boost-1.76.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.76.0_i686/boost-1.76.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.76.0_x86_64/boost-1.76.0-chromeos-x86_64.tpxz',
  })
  binary_sha256 ({
    aarch64: '3faf1c0322845086c77e4ef173beee27ec5fa6c780727c3e6eef85584ee8bc40',
     armv7l: '3faf1c0322845086c77e4ef173beee27ec5fa6c780727c3e6eef85584ee8bc40',
       i686: 'f5f924e7ccaead8a1db56fff2963233d36e5466dc34fcbf7d9527ee00c117aeb',
     x86_64: 'b64b49911d39f51b9460e3ae4ba76f6239b5b2aec473a8376780330ea68b2277',
  })

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
