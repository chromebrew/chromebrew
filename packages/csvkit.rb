require 'package'

class Csvkit < Package
  description 'A suite of utilities for converting to and working with CSV, the king of tabular file formats.'
  homepage 'http://csvkit.rtfd.org/'
  version '1.0.4-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/csvkit/archive/1.0.4.tar.gz'
  source_sha256 'e19c609894c42e850c25af1ca9082753f76f231450f70a70c46344bec45c1a66'

  depends_on 'py3_agate'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
