require 'package'

class Py3_babel < Package
  description 'Babel is a collection of tools for internationalizing python applications.'
  homepage 'https://babel.pocoo.org/'
  version '2.9.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/41/1b/5ed6e564b9ca54318df20ebe5d642ab25da4118df3c178247b8c4b26fa13/Babel-2.9.0.tar.gz'
  source_sha256 'da031ab54472314f210b0adcff1588ee5d1d1d0ba4dbd07b94dba82bde791e05'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
