require 'package'

class Py3_dicttoxml < Package
  description 'DicttoXML converts Python dictionaries into XML strings.'
  homepage 'https://github.com/quandyfactory/dicttoxml/'
  @_ver = '1.3.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/quandyfactory/dicttoxml.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
