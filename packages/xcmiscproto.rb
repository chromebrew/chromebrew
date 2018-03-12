require 'package'

class Xcmiscproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.2.2-0'
  source_url 'https://www.x.org/archive/individual/proto/xcmiscproto-1.2.2.tar.gz'
  source_sha256 '48013cfbe4bd5580925a854a43e2bccbb4c7a5a31128070644617b6dc7f8ef85'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xcmiscproto-1.2.2-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xcmiscproto-1.2.2-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xcmiscproto-1.2.2-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xcmiscproto-1.2.2-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: '4ff4f86ddd1db2157aaf4ad025c43d428fac17da97c442d05186d01072d2264d',
     armv7l: '4ff4f86ddd1db2157aaf4ad025c43d428fac17da97c442d05186d01072d2264d',
       i686: '6e352793117b4500be6b96902523ec0616120c394340cc925d63292e5e5219b1',
     x86_64: 'd73a43374887f030ac3f1eb4313de9527e35d3f739402a206394d79c705e3526',

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
