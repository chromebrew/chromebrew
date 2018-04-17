require 'package'

class Pthread_stubs < Package
  description 'pthread stubs to get libX11 working'
  homepage 'https://x.org'
  version '0.3'
  source_url 'https://xcb.freedesktop.org/dist/libpthread-stubs-0.3.tar.bz2'
  source_sha256 '35b6d54e3cc6f3ba28061da81af64b9a92b7b757319098172488a660e3d87299'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pthread_stubs-0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pthread_stubs-0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pthread_stubs-0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pthread_stubs-0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '12a930c63c5e155059b74c057b342ea4c94f5c1533dd27af55386cd72f920716',
     armv7l: '12a930c63c5e155059b74c057b342ea4c94f5c1533dd27af55386cd72f920716',
       i686: 'a832fa2df7eb69c355a13b2d910230c6dcfd1c49cb263cd787d225c6c751b5a6',
     x86_64: '6d38609d0e19a07642e1e463f68101dffa20b505cb88a443497fbe985cc1e852',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
