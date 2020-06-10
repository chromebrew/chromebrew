require 'package'

class Libsndfile < Package
  description 'Libsndfile is a C library for reading and writing files containing sampled sound (such as MS Windows WAV and the Apple/SGI AIFF format) through one standard library interface.'
  homepage 'http://www.mega-nerd.com/libsndfile/'
  version '1.0.28'
  compatibility 'all'
  source_url 'http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.28.tar.gz'
  source_sha256 '1ff33929f042fa333aed1e8923aa628c3ee9e1eb85512686c55092d1e5a9dfa9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsndfile-1.0.28-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsndfile-1.0.28-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsndfile-1.0.28-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsndfile-1.0.28-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a07e55a380f5ab880d10740824ee36dd0509bf1e84cd30b1d6347df3556ffba4',
     armv7l: 'a07e55a380f5ab880d10740824ee36dd0509bf1e84cd30b1d6347df3556ffba4',
       i686: 'ac2f0640066e55e9c28f373096fb7ddcbb3b5b21af7557a645366f2677b1c612',
     x86_64: '65b4f4f13f020620801e43bbfe9027fc7208d18575727bda56d2ebe75c80e7fc',
  })

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
