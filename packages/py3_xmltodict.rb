require 'package'

class Py3_xmltodict < Package
  description 'Xmltodict makes working with XML feel like you are working with JSON'
  homepage 'https://github.com/martinblech/xmltodict/'
  version '0.12.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/martinblech/xmltodict/archive/v0.12.0.tar.gz'
  source_sha256 'fc19d09c00e35ed92f961a679060dd1d20ece1914f8be7e7c8efddcd30b84250'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
