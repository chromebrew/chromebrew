require 'package'

class Py3_pluggy < Package
  description 'Pluggy provides plugin and hook calling mechanisms for python.'
  homepage 'https://pluggy.readthedocs.io/'
  version '0.13.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/f8/04/7a8542bed4b16a65c2714bf76cf5a0b026157da7f75e87cc88774aa10b14/pluggy-0.13.1.tar.gz'
  source_sha256 '15b2acde666561e1298d71b523007ed7364de07029219b604cf808bfa1c765b0'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
