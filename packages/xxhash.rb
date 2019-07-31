require 'package'

class Xxhash < Package
  description 'xxHash is an extremely fast non-cryptographic hash algorithm, working at speeds close to RAM limits.'
  homepage 'http://cyan4973.github.io/xxHash/'
  version '0.7.0'
  source_url 'https://github.com/Cyan4973/xxHash/archive/v0.7.0.tar.gz'
  source_sha256 'b34792646d5e19964bb7bba24f06cb13aecaac623ab91a54da08aa19d3686d7e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xxhash-0.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9773069f3ec4801c0a77b6e44f9cf32f2a3de8d64e4bb328cf9bcfd311f07b59',
     armv7l: '9773069f3ec4801c0a77b6e44f9cf32f2a3de8d64e4bb328cf9bcfd311f07b59',
       i686: '6ab164331e6031f36742b34e20d58935d86bb427e7790c1fcdf3d86b59df8a84',
     x86_64: '96c0b3684f2e9579764d583c5a0a66d7284d6d586d3fdba03ac3907162142ff2',
  })

  def self.build
    system "make", "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    FileUtils.mkdir_p ["#{CREW_DEST_PREFIX}/bin", "#{CREW_DEST_PREFIX}/man/man1"]
    FileUtils.cp "xxhsum", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.cp "xxhsum.1", "#{CREW_DEST_PREFIX}/man/man1/"
  end
end
