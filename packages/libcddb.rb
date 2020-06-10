require 'package'

class Libcddb < Package
  description 'Libcddb is a C library to access data on a CDDB server (freedb.org).'
  homepage 'http://libcddb.sourceforge.net/'
  version '1.3.2'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/libcddb/libcddb/1.3.2/libcddb-1.3.2.tar.bz2'
  source_sha256 '35ce0ee1741ea38def304ddfe84a958901413aa829698357f0bee5bb8f0a223b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcddb-1.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcddb-1.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcddb-1.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcddb-1.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4f3c225000eeafdaa9129b944d4763c40f823eb195aeafc6996698f651db7d46',
     armv7l: '4f3c225000eeafdaa9129b944d4763c40f823eb195aeafc6996698f651db7d46',
       i686: 'ba523bc37fbcd2278171754f58c042bc9b7d81438857b73803c44d34288a21d8',
     x86_64: 'e98cba9508a10e2a7388e1aea34d49b1387bd029bc35c152abeafae4b54f65f6',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
