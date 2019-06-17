require 'package'

class Lz4 < Package
  description 'LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core (0.16 Bytes/cycle).'
  homepage 'http://lz4.github.io/lz4/'
  version '1.9.1'
  source_url 'https://github.com/lz4/lz4/archive/v1.9.1.tar.gz'
  source_sha256 'f8377c89dad5c9f266edc0be9b73595296ecafd5bfa1000de148096c50052dc4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lz4-1.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lz4-1.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lz4-1.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lz4-1.9.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '49f2396af749a7b8a81469cdaad3d34e2aff8628b84ee7fed55af464d366544d',
     armv7l: '49f2396af749a7b8a81469cdaad3d34e2aff8628b84ee7fed55af464d366544d',
       i686: '5294382301199fe5f1ca42e05cae05ac19dae563d7cb3ba972eb1ae5d55eea5d',
     x86_64: 'a9828980ed376de59fdac2dcc19dac758fc94105a3e363930e7cc81cabef0a10',
  })

  def self.build
    system "make", "BUILD_STATIC=no"
  end

  def self.install
    system "make", "BUILD_STATIC=no", "DESTDIR=#{CREW_DEST_DIR}", "LIBDIR=#{CREW_LIB_PREFIX}", "install"
  end
end
