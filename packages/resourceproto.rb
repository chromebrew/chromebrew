require 'package'

class Resourceproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.2.0-0'
  source_url 'https://www.x.org/archive/individual/proto/resourceproto-1.2.0.tar.gz'
  source_sha256 '469029d14fdeeaa7eed1be585998ff4cb92cf664f872d1d69c04140815b78734'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/resourceproto-1.2.0-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/resourceproto-1.2.0-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/resourceproto-1.2.0-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/resourceproto-1.2.0-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: '79867cc16a5628313f5de2b3e339ce4bf883c681723ce6684bd5577e6ebc4607',
     armv7l: '79867cc16a5628313f5de2b3e339ce4bf883c681723ce6684bd5577e6ebc4607',
       i686: '9ce0365e57d2b6621ee1930f497d8309888f4fb68399a4844fcaeb69b3eec10a',
     x86_64: 'd4a57964f00fb78e5bdd91004e1a3dd655a20eb116d1db5f0fa438e308dbc430',

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
