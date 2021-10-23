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
    aarch64: '33b1882bc2262289aea2f254c03c072ef6460fefe87371ac1b852cbad219cf4a',
     armv7l: '33b1882bc2262289aea2f254c03c072ef6460fefe87371ac1b852cbad219cf4a',
       i686: '7afd36d71494f931cdc758ae8c065a8d0cbf84dbc1ba6f76e9d25e58661bdf77',
     x86_64: 'ba1da68d76045baa0b65704aee05a4ae27c580fbb9e519f01cae1af43a03cb11'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
