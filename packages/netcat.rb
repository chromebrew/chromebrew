require 'package'

class Netcat < Package
  description 'Netcat is a featured networking utility which reads and writes data across network connections, using the TCP/IP protocol.'
  homepage 'http://netcat.sourceforge.net/'
  version '0.7.1'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/netcat/netcat/0.7.1/netcat-0.7.1.tar.gz'
  source_sha256 '30719c9a4ffbcf15676b8f528233ccc54ee6cba96cb4590975f5fd60c68a066f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/netcat-0.7.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/netcat-0.7.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/netcat-0.7.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/netcat-0.7.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '02fa145b9e7d8d956b676fe8ce320d507e00852102bcfbf8c11ab68f340d090a',
     armv7l: '02fa145b9e7d8d956b676fe8ce320d507e00852102bcfbf8c11ab68f340d090a',
       i686: '1d56c30a41a78072ca56aeefa2fa8de161c807d2d6352cae47e1e3ebbc90d1a1',
     x86_64: 'd8eabdf6ac3bd822811c8fc8d5da26dc8a4014cae561a2a77b54c6a1f9a9eff8',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
