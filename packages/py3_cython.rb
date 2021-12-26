require 'package'

class Py3_cython < Package
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  @_ver = '0.29.25'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/cython/cython.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.25_armv7l/py3_cython-0.29.25-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.25_armv7l/py3_cython-0.29.25-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.25_i686/py3_cython-0.29.25-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.25_x86_64/py3_cython-0.29.25-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '42ff5324e9f2f70b0ee4445902ee9f2045dca5fe92dfa99012415472dfd18548',
     armv7l: '42ff5324e9f2f70b0ee4445902ee9f2045dca5fe92dfa99012415472dfd18548',
       i686: '14cdcdcf993e6e4302582ac8285d00e4f4b216ccad741d66b3def5381e23f859',
     x86_64: '1e8c3908182c4bfefc6df5cc5ab5594432952cc2b43af24ab46cb8f93f57b09d'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
