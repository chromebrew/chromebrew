require 'package'

class C_ares < Package
  description 'c-ares is a C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.haxx.se/'
  version '1.15.0'
  compatibility 'all'
  source_url 'https://c-ares.haxx.se/download/c-ares-1.15.0.tar.gz'
  source_sha256 '6cdb97871f2930530c97deb7cf5c8fa4be5a0b02c7cea6e7c7667672a39d6852'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fb85ed9ab22dc4ba7533b67365b56d9ee666580472898432adf3d27d2a20fe3e',
     armv7l: 'fb85ed9ab22dc4ba7533b67365b56d9ee666580472898432adf3d27d2a20fe3e',
       i686: '00ea353730432d9b86c9ddbe05774c2fdcc13dd3cc820c31871410b6d43178f1',
     x86_64: '6587740ad61b5d0a74973235d6e6c01a4e6ea1f5510ee8103ff6e1d2ad045b41',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
