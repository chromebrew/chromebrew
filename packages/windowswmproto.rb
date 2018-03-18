require 'package'

class Windowswmproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.0.4-0'
  source_url 'https://www.x.org/archive/individual/proto/windowswmproto-1.0.4.tar.gz'
  source_sha256 '2dccf510cf18a1b5cfd3a277c678d88303efc85478b479fec46228a861956eb7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/windowswmproto-1.0.4-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/windowswmproto-1.0.4-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/windowswmproto-1.0.4-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/windowswmproto-1.0.4-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '835c2c8034cbf508cb0238cac225d5dde0525a9a8d4717ba804e3068ed028bfc',
     armv7l: '835c2c8034cbf508cb0238cac225d5dde0525a9a8d4717ba804e3068ed028bfc',
       i686: 'afd6bda4b6837a6dbd78ea12679e910f5ad5f515e7e93bc7c9b3925684da0f40',
     x86_64: 'd5241ad70b424941293cf448e3b23d0b08356cd812acd0eaf202def86ffc71ef',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
