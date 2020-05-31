require 'package'

class Qrencode < Package
  description 'Libqrencode is a fast and compact library for encoding data in a QR Code symbol'
  homepage 'https://fukuchi.org/works/qrencode/'
  version '4.0.2'
  source_url 'https://fukuchi.org/works/qrencode/qrencode-4.0.2.tar.gz'
  source_sha256 'dbabe79c07614625d1f74d8c0ae2ee5358c4e27eab8fd8fe31f9365f821a3b1d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qrencode-4.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qrencode-4.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qrencode-4.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qrencode-4.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1135a62562f8a523968b5affb3fbd32cf1068701de6024ab1d1b612b39065cd3',
     armv7l: '1135a62562f8a523968b5affb3fbd32cf1068701de6024ab1d1b612b39065cd3',
       i686: 'a71bbdf13f9a57930d3d0064becdaa57613d3e16fe446e40698bc377881c9175',
     x86_64: '20d0f46764c934a1d32f114c0488fb9b79a1761dbb757d51a009a2547b3cd682',
  })


  depends_on 'libpng'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
