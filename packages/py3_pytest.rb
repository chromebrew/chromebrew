require 'package'

class Py3_pytest < Package
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  @_ver = '6.2.4'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/pytest.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytest/6.2.4_armv7l/py3_pytest-6.2.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytest/6.2.4_armv7l/py3_pytest-6.2.4-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytest/6.2.4_x86_64/py3_pytest-6.2.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd853fbff044481b9f34b630b7e44677a1f2dd3f0a8649eaf52209b9d484db4a3',
     armv7l: 'd853fbff044481b9f34b630b7e44677a1f2dd3f0a8649eaf52209b9d484db4a3',
     x86_64: '30fe0a993bc2c666f7bbc1555fde84e4a2f0c1e1199e5fabd94e25902ab6a71a'
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
