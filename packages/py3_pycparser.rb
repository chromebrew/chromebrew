require 'package'

class Py3_pycparser < Package
  description 'PyCParser is a complete C99 parser in pure Python.'
  homepage 'https://github.com/eliben/pycparser/'
  @_ver = '2.21'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/eliben/pycparser.git'
  git_hashtag 'release_v' + @_ver

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
