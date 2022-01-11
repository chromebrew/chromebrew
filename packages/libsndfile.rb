require 'package'

class Libsndfile < Package
  description 'Libsndfile is a C library for reading and writing files containing sampled sound (such as MS Windows WAV and the Apple/SGI AIFF format) through one standard library interface.'
  homepage 'http://www.mega-nerd.com/libsndfile/'
  version '1.0.28-1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.28.tar.gz'
  source_sha256 '1ff33929f042fa333aed1e8923aa628c3ee9e1eb85512686c55092d1e5a9dfa9'

  depends_on 'libvorbis'
  depends_on 'speex'
  depends_on 'libogg'
  depends_on 'opus'
  depends_on 'flac'
  depends_on 'sqlite'
  depends_on 'alsa_lib'
  depends_on 'nasm'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
