require 'package'

class Libsndfile < Package
  description 'Libsndfile is a C library for reading and writing files containing sampled sound (such as MS Windows WAV and the Apple/SGI AIFF format) through one standard library interface.'
  homepage 'http://www.mega-nerd.com/libsndfile/'
  version '1.0.28'
  source_url 'http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.28.tar.gz'
  source_sha256 '1ff33929f042fa333aed1e8923aa628c3ee9e1eb85512686c55092d1e5a9dfa9'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --disable-dependency-tracking"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
