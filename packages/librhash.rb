require 'package'

class Librhash < Package
  description 'RHash is a console utility for computing and verifying hash sums of files.'
  homepage 'http://rhash.anz.ru/'
  version '1.3.6'
  compatibility 'all'
  source_url 'https://github.com/rhash/RHash/archive/v1.3.6.tar.gz'
  source_sha256 '964df972b60569b5cb35ec989ced195ab8ea514fc46a74eab98e86569ffbcf92'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/librhash-1.3.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/librhash-1.3.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/librhash-1.3.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/librhash-1.3.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dcf9b61860e8a0994f99dc9fbb05d811f1b74cff29eaa22c0303ed910ecb2363',
     armv7l: 'dcf9b61860e8a0994f99dc9fbb05d811f1b74cff29eaa22c0303ed910ecb2363',
       i686: '8df3d5dd347071cb6bdc75aa1b78cbd45449c09785a1131d9a22001f3f8cedf4',
     x86_64: 'c6b8682b1caec42d5146f2864c3d8ea608d1fcdbe638d60897e1e074a3f034a2',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/librhash"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "cp librhash/*.h #{CREW_DEST_PREFIX}/include/librhash"
  end
end
