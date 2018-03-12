require 'package'

class Xf86vidmodeproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.3-0'
  source_url 'https://www.x.org/archive/individual/proto/xf86vidmodeproto-2.3.tar.gz'
  source_sha256 '4bdb8d868f65783f58d9619232a31a2c309e7ae15d24ce5efc579a732aaa271d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xf86vidmodeproto-2.3-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xf86vidmodeproto-2.3-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xf86vidmodeproto-2.3-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xf86vidmodeproto-2.3-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: '674aecc3bf990b96d8779091d1555b32bf2bcf65d56e7a70611b1131dcdb550b',
     armv7l: '674aecc3bf990b96d8779091d1555b32bf2bcf65d56e7a70611b1131dcdb550b',
       i686: '19002ea6322f6b16957eb7139675b225326da54ef8d48f9cae1676ffe6a6d775',
     x86_64: '2d3e9ddad6ca30fd28c8339d9efaea6af3e9dd73c9364ce63fb91b3a49bbccd6',

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
