require 'package'

class Nanomsg < Package
  description 'nanomsg is a socket library that provides several common communication patterns.'
  homepage 'http://nanomsg.org/'
  version '1.0,0'
  source_url 'https://github.com/nanomsg/nanomsg/archive/1.0.0.tar.gz'
  source_sha256 '24afdeb71b2e362e8a003a7ecc906e1b84fd9f56ce15ec567481d1bb33132cc7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nanomsg-1.0,0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nanomsg-1.0,0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nanomsg-1.0,0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nanomsg-1.0,0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6febefbada324ec2b2474d182cbf570c03fbb74e08c40c77eb3d58a6bb100062',
     armv7l: '6febefbada324ec2b2474d182cbf570c03fbb74e08c40c77eb3d58a6bb100062',
       i686: 'f8a6f49ce93b04819d9b7826f2c4859c8b8c1d6561baebfc3964f32ddd4ee45a',
     x86_64: '2e72f87a5c259bcadbef06b3212ef20a1fe7186980634b0f3e00085d62da312f',
  })

  depends_on 'cmake'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
