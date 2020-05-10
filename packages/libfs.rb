require 'package'

class Libfs < Package
  description 'X.org library interface to the X Font Server.'
  homepage 'http://www.x.org'
  version '1.0.7-0'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libFS-1.0.7.tar.gz'
  source_sha256 '91bf1c5ce4115b7dbf4e314fdbee54052708e8f7b6a2ec6e82c309bcbe40ef3d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfs-1.0.7-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfs-1.0.7-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfs-1.0.7-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfs-1.0.7-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '70879f9509e6c33cc7377706e251e53397c772c6ab1d59ffec7370bd6f247eb2',
     armv7l: '70879f9509e6c33cc7377706e251e53397c772c6ab1d59ffec7370bd6f247eb2',
       i686: 'b287f1ae9e043b83b14aa54e23f4abe3b9f10760316e41cedf994be2e1e72a52',
     x86_64: '98f7cc48a3a2406ea1d110b051b3f18f5682b2096cfdb7f4f4f9c4b2255f2f42',
  })

  depends_on 'xorg_proto'
  depends_on 'libxtrans'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
