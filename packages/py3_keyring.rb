require 'package'

class Py3_keyring < Package
  description 'Keyring stores and accesses your passwords safely.'
  homepage 'https://github.com/jaraco/keyring/'
  @_ver = '23.2.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jaraco/keyring.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_keyring/23.0.1_armv7l/py3_keyring-23.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_keyring/23.0.1_armv7l/py3_keyring-23.0.1-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_keyring/23.2.1_i686/py3_keyring-23.2.1-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_keyring/23.2.1_x86_64/py3_keyring-23.2.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1bb40d7217db39f04c41bbd1e45bc95a9d3aeba2259a64fa87449fa00d4e4e6e',
     armv7l: '1bb40d7217db39f04c41bbd1e45bc95a9d3aeba2259a64fa87449fa00d4e4e6e',
    i686: 'dd337f1f94bbdaae210cbeb2e604b9d59b4d855e4222947571de9a51d92039a8',
  x86_64: '2f254913dbc907121271c662011dbdd9c945d265e8dc208ce0e785b38c2ee037'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_secretstorage'
  depends_on 'py3_importlib_metadata'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
