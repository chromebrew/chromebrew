require 'package'

class Flac < Package
  description 'FLAC stands for Free Lossless Audio Codec, an audio format similar to MP3, but lossless, meaning that audio is compressed in FLAC without any loss in quality.'
  homepage 'https://xiph.org/flac/'
  version '1.3.2'
  compatibility 'all'
  source_url 'https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.2.tar.xz'
  source_sha256 '91cfc3ed61dc40f47f050a109b08610667d73477af6ef36dcad31c31a4a8d53f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/flac-1.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/flac-1.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/flac-1.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/flac-1.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'adbc9e93a8d301f82c6cb9ede5392c787bd3994eaf1a963df9c36298f137e08b',
     armv7l: 'adbc9e93a8d301f82c6cb9ede5392c787bd3994eaf1a963df9c36298f137e08b',
       i686: '37d96f3aa15558f3bf2f2191db3b9c346785bc5d16a99027c5332f4fc2374681',
     x86_64: 'f8868c2bcc493dcc7cf51d72531bf6e0be420d883b314847f20eed37251e251b',
  })

  depends_on 'libogg'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
