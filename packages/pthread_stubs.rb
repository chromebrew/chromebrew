require 'package'

class Pthread_stubs < Package
  description 'pthread stubs to get libX11 working'
  homepage 'https://x.org'
  version '0.3'
  source_url 'https://xcb.freedesktop.org/dist/libpthread-stubs-0.3.tar.bz2'
  source_sha256 '35b6d54e3cc6f3ba28061da81af64b9a92b7b757319098172488a660e3d87299'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
