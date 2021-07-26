require 'package'

class Py3_packaging < Package
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  @_ver = '20.9'
  version @_ver
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/pypa/packaging.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/20.9_armv7l/py3_packaging-20.9-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/20.9_armv7l/py3_packaging-20.9-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/20.9_i686/py3_packaging-20.9-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/20.9_x86_64/py3_packaging-20.9-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '455e073afb6ca12d3c4837f97d6c4753ab20093b3a45529199f6331ccae2192b',
     armv7l: '455e073afb6ca12d3c4837f97d6c4753ab20093b3a45529199f6331ccae2192b',
       i686: '9209458660109c6278e1680230cb16f755b6d486e4f7a2b01fcedab80fb12fef',
     x86_64: '976769e26fb5a042068876e1204820ea39177b82eb576e36ed0ecb96b178747c'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
