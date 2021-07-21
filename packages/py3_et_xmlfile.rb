require 'package'

class Py3_et_xmlfile < Package
  description 'Et-xmlfile is an implementation of lxml\'s xmlfile module for the standard library\'s ElementTree.'
  homepage 'https://openpyxl.readthedocs.io/'
  @_ver = '1.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://foss.heptapod.net/openpyxl/et_xmlfile.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
