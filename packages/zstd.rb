require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  version '1.4.7'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd/archive/v1.4.7.tar.gz'
  source_sha256 '085500c8d0b9c83afbc1dc0d8b4889336ad019eba930c5d6a9c6c86c20c769c8'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.7-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.7-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.7-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '4a917969893ff2d985aa498d989219b2c569dd01ff1b198d3e6bd2a770b7d34c',
      armv7l: '4a917969893ff2d985aa498d989219b2c569dd01ff1b198d3e6bd2a770b7d34c',
        i686: '192b17e599990e94d2d8343095c90be85e0013fe92c8933c6795c51f8ba39d89',
      x86_64: '017e2d9e5fa613bb50385f6b49bb9642f7b3e6f10453e46b89ea3e4701a39ae7',
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
