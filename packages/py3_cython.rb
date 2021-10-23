require 'package'

class Py3_cython < Package
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  @_ver = '0.29.24'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/cython/cython.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.24_armv7l/py3_cython-0.29.24-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.24_armv7l/py3_cython-0.29.24-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.24_i686/py3_cython-0.29.24-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.24_x86_64/py3_cython-0.29.24-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e7c3a371e47dc9fc65e8266daa196351c9e8b7f71084414c5cea298349d2d006',
     armv7l: 'e7c3a371e47dc9fc65e8266daa196351c9e8b7f71084414c5cea298349d2d006',
       i686: '09c5cd05ad4fe29c43a1859a7b9c870298cbd429bf74a275928972308ce16e8e',
     x86_64: '18c5eac4bd891ac49969a6b43b039685b8d1f531d7a95ba5f8d2f80fd0c855ac'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
