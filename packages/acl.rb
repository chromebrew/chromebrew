require 'package'

class Acl < Package
  description 'Commands for Manipulating POSIX Access Control Lists.'
  homepage 'http://savannah.nongnu.org/projects/acl'
  version '2.2.53'
  compatibility 'all'
  source_url 'https://bigsearcher.com/mirrors/nongnu/acl/acl-2.2.53.tar.gz'
  source_sha256 '06be9865c6f418d851ff4494e12406568353b891ffe1f596b34693c387af26c7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/acl-2.2.53-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/acl-2.2.53-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/acl-2.2.53-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/acl-2.2.53-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '63d5600ce26933fc49b5fea4a9ab37f1dac8546c9a2bee6d0525ced6b98c03bb',
     armv7l: '63d5600ce26933fc49b5fea4a9ab37f1dac8546c9a2bee6d0525ced6b98c03bb',
       i686: 'a6859cfa0dc95c84304e49e90bbabc19f99a88daf962c58ff83914acd87f151e',
     x86_64: '3dc686dbda7dd835281a0e9f54fb0740bd4fcb318c273bc78bbe75a402b906d9',
  })

  depends_on 'attr'

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
