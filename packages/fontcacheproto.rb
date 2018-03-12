require 'package'

class Fontcacheproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '0.13-0'
  source_url 'https://www.x.org/archive/individual/proto/fontcacheproto-0.1.3.tar.gz'
  source_sha256 '759b4863b55a25bfc8f977d8ed969da0b99b3c823f33c674d6da5825f9df9a79'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fontcacheproto-0.13-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fontcacheproto-0.13-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fontcacheproto-0.13-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fontcacheproto-0.13-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: '0bbddf86e17621f4468eec33315144f45578559d384659b3c6459cd5d266d2ec',
     armv7l: '0bbddf86e17621f4468eec33315144f45578559d384659b3c6459cd5d266d2ec',
       i686: '28ad56f0cb12569f78f36e5146aa9f69d9e3598180f43d2af5aaef553dd39241',
     x86_64: 'c0ef996e30126687de2d91b4670e3562ecb9399f12e5e2635bb0f5dd3954265b',

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
