require 'package'

class Xproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '7.0.31-0'
  source_url 'https://www.x.org/archive/individual/proto/xproto-7.0.31.tar.gz'
  source_sha256 '6d755eaae27b45c5cc75529a12855fed5de5969b367ed05003944cf901ed43c7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xproto-7.0.31-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xproto-7.0.31-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xproto-7.0.31-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xproto-7.0.31-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '05e8827e263aa90a9fdb975a1ee60991c6f28ea2b8f496a2c8974b0e9e5cc62d',
     armv7l: '05e8827e263aa90a9fdb975a1ee60991c6f28ea2b8f496a2c8974b0e9e5cc62d',
       i686: '47444e90bba09dfe4babf1da998e0a7a9cfaaf33c24bf5818db1c22144c38bef',
     x86_64: '78ceed191b2c3689e68cc6303c66ce93d1ca8ce218e643476ab5d03260fdeff1',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
