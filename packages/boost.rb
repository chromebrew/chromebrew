require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'https://www.boost.org/'
  version "1.90.0-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'Boost-1.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://archives.boost.io/release/#{version.split('-')[0]}/source/boost_#{version.split('-')[0].gsub('.', '_')}.tar.bz2"
  source_sha256 '49551aff3b22cbc5c5a9ed3dbc92f0e23ea50a0f7325b0d198b705e8ee3fc305'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea9d77bf41aee321dd3892cfb5d3bc6753715f2faaec9fd58a65bf51317802c6',
     armv7l: 'ea9d77bf41aee321dd3892cfb5d3bc6753715f2faaec9fd58a65bf51317802c6',
     x86_64: 'b391131bebded0ecca3a3ad81f1d9ef638ec3e6f794c2622bb7b2b0f5ea6c638'
  })

  depends_on 'bzip2' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'icu4c' => :library
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
