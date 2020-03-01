require 'package'

class Qrencode < Package
  description 'Libqrencode is a fast and compact library for encoding data in a QR Code symbol'
  homepage 'https://fukuchi.org/works/qrencode/'
  version '4.0.2'
  source_url 'https://fukuchi.org/works/qrencode/qrencode-4.0.2.tar.gz'
  source_sha256 'dbabe79c07614625d1f74d8c0ae2ee5358c4e27eab8fd8fe31f9365f821a3b1d'

  binary_url ({
  })
  binary_sha256 ({
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
