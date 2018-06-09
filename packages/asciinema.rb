require 'package'

class Asciinema < Package
  description 'Terminal session recorder'
  homepage 'https://asciinema.org/'
  version '2.0.1'
  source_url 'https://github.com/asciinema/asciinema/archive/v2.0.1.tar.gz'
  source_sha256 '7087b247dae36d04821197bc14ebd4248049592b299c9878d8953c025ac802e4'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3'

  def self.install
    system "pip3 install setuptools"
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
