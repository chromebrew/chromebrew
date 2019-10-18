require 'package'

class Csvkit < Package
  description 'A suite of utilities for converting to and working with CSV, the king of tabular file formats.'
  homepage 'http://csvkit.rtfd.org/'
  version '1.0.4'
  source_url 'https://github.com/wireservice/csvkit/archive/1.0.4.tar.gz'
  source_sha256 'e19c609894c42e850c25af1ca9082753f76f231450f70a70c46344bec45c1a66'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'setuptools'

  def self.install
    system "pip install --prefix #{CREW_PREFIX} \
            --root #{CREW_DEST_DIR} \
            -r requirements-py2.txt \
            -r requirements-py3.txt csvkit"
  end
end
