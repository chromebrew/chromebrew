require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'https://www.boost.org/'
  version '1.85.0-py3.12'
  license 'Boost-1.0'
  compatibility 'all'
  source_url "https://boostorg.jfrog.io/artifactory/main/release/#{version.split('-').first}/source/boost_#{version.split('-').first.gsub('.', '_')}.tar.bz2"
  source_sha256 '7009fe1faa1697476bdc7027703a2badb84e849b7b0baad5086b087b971f8617'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b4db9eb12101b140b6071bcf65e24e7d541728f9e64f4c71fa3dff3adf1ac208',
     armv7l: 'b4db9eb12101b140b6071bcf65e24e7d541728f9e64f4c71fa3dff3adf1ac208',
       i686: '2d68696fe8469881653e45579750952424537e6e2f7aad0c19957a3f570488e0',
     x86_64: '8043b7745e036cf75717b1c8b59700d41fdff0479536b375a71a6054ce73d3d9'
  })

  depends_on 'bzip2' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'python3' => :build
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
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
