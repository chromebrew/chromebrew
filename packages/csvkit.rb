require 'package'

class Csvkit < Package
  description 'A suite of utilities for converting to and working with CSV, the king of tabular file formats.'
  homepage 'http://csvkit.rtfd.org/'
  version '1.0.4'
  compatibility 'all'
  source_url 'https://github.com/wireservice/csvkit/archive/1.0.4.tar.gz'
  source_sha256 'e19c609894c42e850c25af1ca9082753f76f231450f70a70c46344bec45c1a66'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/csvkit-1.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/csvkit-1.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/csvkit-1.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/csvkit-1.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b6d48277e99c02a4ae4afffed955682def7326cc6e24be797d35719cefb9f086',
     armv7l: 'b6d48277e99c02a4ae4afffed955682def7326cc6e24be797d35719cefb9f086',
       i686: 'dd6f3a7878131e5b5801415ef96f3b8462b32d3df95c59255194b5bc09e2d4c7',
     x86_64: '01d05a5337a2aeb7488ad7129cc19ac342e6dac19fe07f7487a4ec3cd0751d78',
  })

  depends_on 'setuptools'

  def self.install
    system "pip install --prefix #{CREW_PREFIX} \
            --root #{CREW_DEST_DIR} \
            -r requirements-py2.txt \
            -r requirements-py3.txt csvkit"
  end
end
