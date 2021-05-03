require 'package'

class Py3_cython < Package
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  @_ver = '0.29.23'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/cython/cython.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.23_armv7l/py3_cython-0.29.23-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.23_armv7l/py3_cython-0.29.23-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.23_i686/py3_cython-0.29.23-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.23_x86_64/py3_cython-0.29.23-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4febe216fea2a366bded23e9522d7984190fd0d65e446f5d89857ca9f4938e3b',
     armv7l: '4febe216fea2a366bded23e9522d7984190fd0d65e446f5d89857ca9f4938e3b',
       i686: '21c38b0a8f73120fedfade5db08b69e4cca5c7a1cd6595e5a84fcc177eccee43',
     x86_64: '1e4761d551e1ee2232d7a6af7be63c0f5ef7ab8cd1cb5f1fe9f22abafd346369'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
