require 'package'

class Py3_pyte < Package
  description 'PyTE is a Simple VTXXX-compatible terminal emulator.'
  homepage 'https://github.com/selectel/pyte/'
  @_ver = '0.8.0'
  version @_ver
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/selectel/pyte.git'
  git_hashtag @_ver

  depends_on 'py3_wcwidth'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
