require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'https://www.boost.org/'
  version "1.90.0-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'Boost-1.0'
  compatibility 'all'
  source_url "https://archives.boost.io/release/#{version.split('-').first}/source/boost_#{version.split('-').first.gsub('.', '_')}.tar.bz2"
  source_sha256 '49551aff3b22cbc5c5a9ed3dbc92f0e23ea50a0f7325b0d198b705e8ee3fc305'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a59f454f9f6b1a6639e3e321302fc2226f4807fd8d940299804b9720bb6d7f0d',
     armv7l: 'a59f454f9f6b1a6639e3e321302fc2226f4807fd8d940299804b9720bb6d7f0d',
       i686: 'fc521694660afaa6a164efe4b82dbca5861799801d8c47b78f46ed840b27da7b',
     x86_64: 'eec7fe6a9c7bed95592c758df739230383d2c5913085f709f42aa82d19d2e2cf'
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
