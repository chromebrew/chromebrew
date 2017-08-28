require 'package'

class Xcmiscproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.2.2'
  source_url 'https://www.x.org/archive/individual/proto/xcmiscproto-1.2.2.tar.gz'
  source_sha256 '48013cfbe4bd5580925a854a43e2bccbb4c7a5a31128070644617b6dc7f8ef85'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xcmiscproto-1.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xcmiscproto-1.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xcmiscproto-1.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xcmiscproto-1.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c2646256dfcef6f914a351e8d30310e6dad84e904d807021c58616d6debf2c1c',
     armv7l: 'c2646256dfcef6f914a351e8d30310e6dad84e904d807021c58616d6debf2c1c',
       i686: 'f7d79f0237904fce603e238554909549368c32869ff9962d22833f2534c0440c',
     x86_64: 'f98ac6dae554d71a3b3399b78ad542975608de1910f6a6ca6f5ac869cfdeb454',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
