require 'package'

class Memcached < Package
  description 'Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.'
  homepage 'https://memcached.org/'
  version '1.5.3'
  source_url 'https://memcached.org/files/memcached-1.5.3.tar.gz'
  source_sha256 '258cc3ddb7613685465acfd0215f827220a3bbdd167fd2c080632105b2d2f3ce'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/memcached-1.5.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/memcached-1.5.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/memcached-1.5.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/memcached-1.5.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '24640b0e777ede59135083f836f2e2dbfdb007d943d48c23719af2ff63d8c7c5',
     armv7l: '24640b0e777ede59135083f836f2e2dbfdb007d943d48c23719af2ff63d8c7c5',
       i686: 'c544b7afdcdc6307e9aa547f3ab238d6daeb8d064625177622207ffa3ebe9fde',
     x86_64: '0ae6afff645bddd1fdebe42fcc1289c9ec259901e89e6312e0c94054061402ee',
  })

  depends_on 'libevent'

  def self.build
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
