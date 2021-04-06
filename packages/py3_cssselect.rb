require 'package'

class Py3_cssselect < Package
  description 'cssselect parses CSS3 Selectors and translate them to XPath 1.0 expressions.'
  homepage 'https://cssselect.readthedocs.io/'
  version '1.1.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/scrapy/cssselect/archive/v1.1.0.tar.gz'
  source_sha256 'dde8c1d4a2c82de6889a3af1c1adbce1a6f3ec08b07a854d873f3f3da92960af'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
