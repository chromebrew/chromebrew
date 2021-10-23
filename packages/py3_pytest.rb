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
    aarch64: '076f26ea6bb78a39adaee5fed0cef6a816605e912aa2b22272b536a50778204c',
     armv7l: '076f26ea6bb78a39adaee5fed0cef6a816605e912aa2b22272b536a50778204c',
       i686: '8787f0a8fc8266eaa828c3d76ff57f3088419fd8de45b438434a8a53bcbd1097',
     x86_64: '1af0977941d9b5e8bbd93b6671503cd019e8cae21efea39db52ec83bb2295ba8'
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
