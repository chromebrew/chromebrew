require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'https://www.boost.org/'
  @_ver = '1.83.0'
  version "#{@_ver}-py3.12"
  license 'Boost-1.0'
  compatibility 'all'
  source_url "https://boostorg.jfrog.io/artifactory/main/release/#{@_ver}/source/boost_#{@_ver.gsub('.', '_')}.tar.bz2"
  source_sha256 '6478edfe2f3305127cffe8caf73ea0176c53769f4bf1585be237eb30798c3b8e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.83.0-py3.12_armv7l/boost-1.83.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.83.0-py3.12_armv7l/boost-1.83.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.83.0-py3.12_i686/boost-1.83.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/boost/1.83.0-py3.12_x86_64/boost-1.83.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'aaba4692f5b89a656e8df9ad4a3fe3c25d9c66fd669d47aa0d6efeedf8448c3c',
     armv7l: 'aaba4692f5b89a656e8df9ad4a3fe3c25d9c66fd669d47aa0d6efeedf8448c3c',
       i686: '3849a5ecaaf51d4d5e166d944e220ff627cbf69a781d756d66a3f27097085e77',
     x86_64: '892447b1c026b67f7d7c2e389be5953b2581db69bd0e44079fac9c3575e244f6'
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
