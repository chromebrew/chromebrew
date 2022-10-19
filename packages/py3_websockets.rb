require 'package'

class Py3_websockets < Package
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  @_ver = '10.3'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/aaugustin/websockets.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
