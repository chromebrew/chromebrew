require 'package'

class Py3_mistune < Package
  description 'Mistune is the fastest markdown parser in pure python.'
  homepage 'http://mistune.readthedocs.io/'
  version '0.8.4'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/lepture/mistune/archive/v0.8.4.tar.gz'
  source_sha256 'a1443771ea9ed7268a0cb3cf31462604ae148938ba32070bd5c54545f8f36a5d'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
