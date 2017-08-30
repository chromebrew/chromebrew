require 'package'

class Memcached < Package
  description 'Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.'
  homepage 'https://memcached.org/'
  version '1.5.1'
  source_url 'https://memcached.org/files/memcached-1.5.1.tar.gz'
  source_sha256 'a87908936b51d1bd3ef10a2347eef5647f003b63407a5d8161fa7928b1cd6b5c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/memcached-1.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/memcached-1.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/memcached-1.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/memcached-1.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '21f95bb2d9f7034a894629340dccb498419fad98d831737ef2e8464fdabff92d',
     armv7l: '21f95bb2d9f7034a894629340dccb498419fad98d831737ef2e8464fdabff92d',
       i686: '0afb5959638e2c18184ef65fcc460f84edd618d522a3221c632175b8fe18d665',
     x86_64: 'd3bddaab1921ee3d11b6eae45ad6933abebc41383fc3bb1f14ee666da582edb9',
  })

  depends_on 'libevent'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
