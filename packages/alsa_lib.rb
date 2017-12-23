require 'package'

class Alsa_lib < Package
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.1.5'
  source_url 'ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.1.5.tar.bz2'
  source_sha256 'f4f68ad3c6da36b0b5241ac3c798a7a71e0e97d51f972e9f723b3f20a9650ae6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '10b105f4ca993f0d24035fe6bdcec6e8637c768be301757d4040e6dd166d235c',
     armv7l: '10b105f4ca993f0d24035fe6bdcec6e8637c768be301757d4040e6dd166d235c',
       i686: '4be56a32b5149e53aa05e15a87a50da8d3b8a25eafbabe2fd3ea436ba2fa0df5',
     x86_64: '82a8be3966832edbcd42306d5d3920fe3bbcb1cdcb594e375f6f8f4335030abf',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
