require 'package'

class Py3_mock < Package
  description 'Mock is a testing library in Python.'
  homepage 'https://mock.readthedocs.org/'
  @_ver = '4.0.3'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/testing-cabal/mock.git'
  git_hashtag @_ver

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
