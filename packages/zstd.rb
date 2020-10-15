require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  version '1.4.5'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd/archive/v1.4.5.tar.gz'
  source_sha256 '734d1f565c42f691f8420c8d06783ad818060fc390dee43ae0a89f86d0a4f8c2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5cf9b496bf10ca56ab900bc0b2b82ed3e30493a1bbdc170a456ff73454531bfc',
     armv7l: '5cf9b496bf10ca56ab900bc0b2b82ed3e30493a1bbdc170a456ff73454531bfc',
       i686: '184413b92f95c5fad0ca8724f4fb231018c46f8b24b42d39a2f892f034548dc1',
     x86_64: 'a0fef2e2ed65835399ff8435bb806e74fe8b9e4e3019889a284bdd422fd1979a',
  })

  depends_on 'lz4' => ':build'
  
  def self.build
    system 'make'
  end

  def self.install
    system 'make',
           "DESTDIR=#{CREW_DEST_DIR}",
           "PREFIX=#{CREW_PREFIX}",
           "LIBDIR=#{CREW_LIB_PREFIX}",
           'install'
  end
end
