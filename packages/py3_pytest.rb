require 'package'

class Py3_pytest < Package
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  @_ver = '6.2.5'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/pytest.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytest/6.2.5-py3.11_armv7l/py3_pytest-6.2.5-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytest/6.2.5-py3.11_armv7l/py3_pytest-6.2.5-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytest/6.2.5-py3.11_i686/py3_pytest-6.2.5-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytest/6.2.5-py3.11_x86_64/py3_pytest-6.2.5-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '377a930b5eedaaab8d7b4fa321b4690db92b609474f3151956a735d3e5d84dfd',
     armv7l: '377a930b5eedaaab8d7b4fa321b4690db92b609474f3151956a735d3e5d84dfd',
       i686: 'b3966c8d25c027c085a3d79fdfeb97c4e36748357bf7661545c87bdd6e8a348d',
     x86_64: '420ac656d06e45d1097691d0c441751909e9e7a619f5a1fa39af861abfb5c36f'
  })

  depends_on 'py3_py'
  depends_on 'py3_toml'
  depends_on 'py3_packaging'
  depends_on 'py3_attrs'
  depends_on 'py3_pluggy'
  depends_on 'py3_iniconfig'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
