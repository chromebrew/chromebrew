require 'package'

class Py3_xlsxwriter < Package
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  @_ver = '1.4.2'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/jmcnamara/XlsxWriter.git'
  git_hashtag 'RELEASE_' + @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
