require 'package'

class Py3_pytest < Package
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  @_ver = '6.2.5'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/pytest.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytest/6.2.5_armv7l/py3_pytest-6.2.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytest/6.2.5_armv7l/py3_pytest-6.2.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytest/6.2.5_i686/py3_pytest-6.2.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytest/6.2.5_x86_64/py3_pytest-6.2.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e07eb2dc508c1710332cdf74a023c30d6c1805166ed8c4aea52e56e7b8afbe45',
     armv7l: 'e07eb2dc508c1710332cdf74a023c30d6c1805166ed8c4aea52e56e7b8afbe45',
       i686: 'c2f645998e899eab99998914fe74a65c83f16f4f688fdcb1ded0c5345a0891e6',
     x86_64: '090b9bea45cafcc0b83fd11024a5fa149758c94b355e213c1c18f8bff5fad5f3'
  })

  depends_on 'py3_py'
  depends_on 'py3_toml'
  depends_on 'py3_packaging'
  depends_on 'py3_attrs'
  depends_on 'py3_pluggy'
  depends_on 'py3_iniconfig'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
