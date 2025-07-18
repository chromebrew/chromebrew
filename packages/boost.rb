require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'https://www.boost.org/'
  version "1.85.0-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'Boost-1.0'
  compatibility 'all'
  source_url "https://archives.boost.io/release/#{version.split('-').first}/source/boost_#{version.split('-').first.gsub('.', '_')}.tar.bz2"
  source_sha256 '07911da8fe22fb10e3918528a8f0a5676f03c0b3b135ac19c26779f6804baebe'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a8b31c3ea2d515e867ee006eb68a5958536044cf3009513c1b2753cf982a28d',
     armv7l: '0a8b31c3ea2d515e867ee006eb68a5958536044cf3009513c1b2753cf982a28d',
       i686: '693ffb63a554775b6bd0a106dc08e1a1c2840a507cc884818f2e2ecf6ccc2844',
     x86_64: '3ed4dc23d4011a5f1d77a70004ddec926b7cde25ece5cdc23e59e63d32fc5a86'
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
