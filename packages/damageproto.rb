require 'package'

class Damageproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.2.1-0'
  source_url 'https://www.x.org/archive/individual/proto/damageproto-1.2.1.tar.gz'
  source_sha256 'f65ccbf1de9750a527ea6e85694085b179f2d06495cbdb742b3edb2149fef303'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/damageproto-1.2.1-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/damageproto-1.2.1-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/damageproto-1.2.1-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/damageproto-1.2.1-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: '2dfaf7ed3ed40edc67cee50e0e5def2ab40458db74290a3855a05dde207d0d56',
     armv7l: '2dfaf7ed3ed40edc67cee50e0e5def2ab40458db74290a3855a05dde207d0d56',
       i686: 'd2c1f1a61de4405e3b086c8162b295958e025eb594edc5eb5428d7a355dfb338',
     x86_64: 'f0f94e9c78a3b97bbcf09892d7be2ac59c4ed4e78365a59fc07cd17dbb79658e',

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
