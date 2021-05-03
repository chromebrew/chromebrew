require 'package'

class Py3_xmltodict < Package
  description 'XMLtoDict makes working with XML feel like you are working with JSON.'
  homepage 'https://github.com/martinblech/xmltodict/'
  @_ver = '0.12.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/martinblech/xmltodict.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
