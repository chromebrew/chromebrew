require 'package'

class Py3_py < Package
  description 'Py is a library with cross-python path, ini-parsing, io, code, log facilities.'
  homepage 'https://py.readthedocs.io/'
  @_ver = '1.11.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/py.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.11.0-py3.11_armv7l/py3_py-1.11.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.11.0-py3.11_armv7l/py3_py-1.11.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.11.0-py3.11_i686/py3_py-1.11.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.11.0-py3.11_x86_64/py3_py-1.11.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f20572c21ca4f395805bb6c461d17958f5a05dc8bcf7bf3f2a82755923a63f97',
     armv7l: 'f20572c21ca4f395805bb6c461d17958f5a05dc8bcf7bf3f2a82755923a63f97',
       i686: '2bd51c52f92e1ddccae779a4cd6e3278ff6f80756e1cc5c6ca7371acd239f143',
     x86_64: 'f5e7aa19171b7cee8757a6cf3c21330a483f140cc55aec8143d345b40eba05fe'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
