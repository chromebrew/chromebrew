require 'package'

class Py3_certifi < Package
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/' # 403 Forbidden on 2021.05.08, still 403 Forbidden on 2021.10.13
  @_ver = '2021.10.08'
  version @_ver
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/certifi/python-certifi.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2021.10.08_armv7l/py3_certifi-2021.10.08-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2021.10.08_armv7l/py3_certifi-2021.10.08-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2021.10.08_i686/py3_certifi-2021.10.08-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_certifi/2021.10.08_x86_64/py3_certifi-2021.10.08-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5cd446c1cdece3de96b30ca059f921d551c78a5d8498c6b5688900d882d51e16',
     armv7l: '5cd446c1cdece3de96b30ca059f921d551c78a5d8498c6b5688900d882d51e16',
       i686: '6a21972e1d4121df2a7976ddafc717c073248adca92ac746b2c7b57bd9738406',
     x86_64: '3991ddac144d3294f2f718181a8239e160bcbb916ac329519161eae8eb58cb7f'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
