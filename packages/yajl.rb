require 'package'

class Yajl < Package
  description 'A fast streaming JSON parsing library in C.'
  homepage 'http://lloyd.github.io/yajl/'
  version '2.1.0-4'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/lloyd/yajl/archive/refs/tags/2.1.0.tar.gz'
  source_sha256 '3fb73364a5a30efe615046d07e6db9d09fd2b41c763c5f7d3bfb121cd5c5ac5a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'be4e182188a8f042b65865dae2af1dd1312d6a2c0edfd9cb8da75999927ee174',
     armv7l: 'be4e182188a8f042b65865dae2af1dd1312d6a2c0edfd9cb8da75999927ee174',
       i686: 'cd4f672d43eba7368b08e4d0a71baf40daa5562ae789e3150ff941293e6fb64e',
     x86_64: 'efea10c9cbb546dd9e5877047299b3d76c78ea106a10484bdeb0e062e49222c2'
  })

  depends_on 'glibc' # R

  def self.patch
    # Fix CVE-2022-24795
    downloader 'https://patch-diff.githubusercontent.com/raw/lloyd/yajl/pull/242.patch',
               '28cf573e61ad5d442dc3ea23912e1d1a3a714c6f20a647304fbd5a886b457f29'
    system 'patch -Np1 -i 242.patch'
    #  Fixes incorrect lower bound for integers
    downloader 'https://patch-diff.githubusercontent.com/raw/lloyd/yajl/pull/251.patch',
               '24b6928e87f388f633b51b98025c15ca6cd40c4cd388278cbb98bd06c64be719'
    system 'patch -Np1 -i 251.patch'
  end

  def self.build
    system "cmake -B builddir -G Ninja \
      #{CREW_CMAKE_LIBSUFFIX_OPTIONS} \
      -Wno-dev"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
