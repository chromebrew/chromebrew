require 'package'

class Pyconfigure < Package
  description 'GNU pyconfigure provides developers with file templates for implementing standard configure scripts and Makefile recipes for their Python packages.'
  homepage 'https://www.gnu.org/software/pyconfigure/'
  version '0.2.3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/pyconfigure/pyconfigure-0.2.3.tar.gz'
  source_sha256 '37438ee1ae0aad7692188c7d01218cb407a1c89f3efdb5d360311b7ade4ab14f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pyconfigure-0.2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pyconfigure-0.2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pyconfigure-0.2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pyconfigure-0.2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c0f11115eee3859c7bb69ee00c3f5f3273c3feb17b638be1027df23f723724de',
     armv7l: 'c0f11115eee3859c7bb69ee00c3f5f3273c3feb17b638be1027df23f723724de',
       i686: 'cb8dbc28d3d213c5b2191dad54185ecbff30c71a46b0e80336586b8c338a6def',
     x86_64: 'b9e78285f0fc67ecc26d037de703987628e966b0d63fcfeba0498e8938d01446',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
