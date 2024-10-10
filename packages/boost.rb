require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'https://www.boost.org/'
  version "1.85.0-#{CREW_ICU_VER}-#{CREW_PY_VER}"
  license 'Boost-1.0'
  compatibility 'all'
  source_url "https://boostorg.jfrog.io/artifactory/main/release/#{version.split('-').first}/source/boost_#{version.split('-').first.gsub('.', '_')}.tar.bz2"
  source_sha256 '7009fe1faa1697476bdc7027703a2badb84e849b7b0baad5086b087b971f8617'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d0ee487577eace4b5fd7e479dc9c08891036b122f198ccd47b209147b38cbe9',
     armv7l: '7d0ee487577eace4b5fd7e479dc9c08891036b122f198ccd47b209147b38cbe9',
       i686: 'c32bc6ac43f9bfc06787cfb034cb0c38c91af5b4297ded00702ce491cc6f7a3f',
     x86_64: '61413bd082a6e53f2ca3da765c39df97a5fbd7c727e69666cfa10a2c667e9a7a'
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
