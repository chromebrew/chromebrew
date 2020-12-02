require 'package'

class Isl < Package
  description 'Integer Set Library for manipulating sets and relations of integer points bounded by linear constraints'
  homepage 'http://isl.gforge.inria.fr/'
  version '0.23'
  compatibility 'all'
  source_url 'http://isl.gforge.inria.fr/isl-0.23.tar.xz'
  source_sha256 '5efc53efaef151301f4e7dde3856b66812d8153dede24fab17673f801c8698f2'


  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    # For backwards compatibility:
    FileUtils.ln_sf "#{CREW_PREFIX}/libisl.so.23.0.0", "#{CREW_DEST_LIB_PREFIX}/libisl.so.15"
    FileUtils.ln_sf "#{CREW_PREFIX}/libisl.so.23.0.0", "#{CREW_DEST_LIB_PREFIX}/libisl.so.19"
  end

  def self.check
    system 'make', 'check'
  end
end
