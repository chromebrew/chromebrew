require 'package'

class Textract < Package
  description 'Extract text from any document.'
  homepage 'http://textract.readthedocs.io/en/stable/'
  version '1.6.1'
  compatibility 'all'
  source_url 'https://github.com/deanmalmgren/textract/archive/v1.6.1.tar.gz'
  source_sha256 '9e5e2132db126646031134f7a84efbf10f631a3d0fb56bc8881f67998890dfac'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/textract-1.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/textract-1.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/textract-1.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/textract-1.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '77b0b5be2d908bf3e82e57e23c657edc4e556b87dc3d8790aba158e5509b87c7',
     armv7l: '77b0b5be2d908bf3e82e57e23c657edc4e556b87dc3d8790aba158e5509b87c7',
       i686: 'f5e52a3dcb931ad25d4847b47f41c50f9eee454d24169603c13f5cb800df59ca',
     x86_64: '13e5933fe8082e152cdf80c661f85f9a425e2a303ace296cf82e8d302da39551',
  })

  depends_on 'setuptools'
  depends_on 'pulseaudio'
  depends_on 'swig'

  def self.install
    system "pip3 install textract --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end
end
