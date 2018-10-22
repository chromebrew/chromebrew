require 'package'

class Alsa_lib < Package
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.1.7'
  source_url 'ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.1.7.tar.bz2'
  source_sha256 '9d6000b882a3b2df56300521225d69717be6741b71269e488bb20a20783bdc09'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.1.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.1.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.1.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.1.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4b382a9eaed1d08d1c7ba1906a4b155476c691c9ee1d8f9852af655a933b3c59',
     armv7l: '4b382a9eaed1d08d1c7ba1906a4b155476c691c9ee1d8f9852af655a933b3c59',
       i686: 'cb22d0641935cc10dcf4d01838e2eed3a8e8f690b1ccb0741da87336fa29a43b',
     x86_64: '0e5b6e000aedc2ffc9264eb62bf0afb03e06a86a7803c6105489758b14e822f5',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
