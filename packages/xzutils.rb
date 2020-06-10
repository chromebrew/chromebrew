require 'package'

class Xzutils < Package
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'http://tukaani.org/xz/'
  version '5.2.5'
  compatibility 'all'
  source_url 'https://tukaani.org/xz/xz-5.2.5.tar.gz'
  source_sha256 'f6f4910fd033078738bd82bfba4f49219d03b17eb0794eb91efbae419f4aba10'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xzutils-5.2.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xzutils-5.2.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xzutils-5.2.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xzutils-5.2.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bbb38dfbc5f7845dde5d4e6c1aa46be40d4d94f5db26b0aa20f1603a14c6e61d',
     armv7l: 'bbb38dfbc5f7845dde5d4e6c1aa46be40d4d94f5db26b0aa20f1603a14c6e61d',
       i686: '34db46c8dc58db4c212ba83e36eba17c8852eab14964a6a1d7ab75aaf23be91c',
     x86_64: '05f0e86514ed8fefa240e0fc2d40cb2b95414d628f670b19a230a3867e992a24',
  })

  def self.build
    system './configure', "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-docs', '--enable-shared', '--disable-static', '--with-pic'
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
