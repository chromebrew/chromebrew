require 'package'

class Libv4l < Package
  description 'A collection of video4linux libraries.'
  homepage 'https://linuxtv.org/'
  version '1.16.3'
  source_url 'https://linuxtv.org/downloads/v4l-utils/v4l-utils-1.16.3.tar.bz2'
  source_sha256 '7c5c0d49c130cf65d384f28e9f3a53c5f7d17bf18740c48c40810e0fbbed5b54'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libsdl2'
  depends_on 'libglu'
  depends_on 'alsa_lib'
  depends_on 'ld_default'

  def self.build
    system 'ld_default g'
    system "./configure",
           "--disable-static",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'ld_default b'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
