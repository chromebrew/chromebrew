require 'package'

class Speex < Package
  description 'Speex is an Open Source/Free Software patent-free audio compression format designed for speech.'
  homepage 'https://speex.org/'
  version '1.2.0'
  source_url 'http://downloads.us.xiph.org/releases/speex/speex-1.2.0.tar.gz'
  source_sha256 'eaae8af0ac742dc7d542c9439ac72f1f385ce838392dc849cae4536af9210094'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/speex-1.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/speex-1.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/speex-1.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/speex-1.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '37faba178b4920e80d8746cea977f8dec9dff6678d90caf8f9767dfe003806cb',
     armv7l: '37faba178b4920e80d8746cea977f8dec9dff6678d90caf8f9767dfe003806cb',
       i686: '1242e0062a80cc9652d2e47033a4f9c8f1178ba871192068b1a80cdbfd0ec2ef',
     x86_64: '8ec8514f302df75268416a09362f475bb24d73779adc7b1c7b446d40bc6f9e26',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
