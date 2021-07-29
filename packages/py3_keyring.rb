require 'package'

class Py3_keyring < Package
  description 'Keyring stores and accesses your passwords safely.'
  homepage 'https://github.com/jaraco/keyring/'
  @_ver = '23.0.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jaraco/keyring.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_keyring/23.0.1_armv7l/py3_keyring-23.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_keyring/23.0.1_armv7l/py3_keyring-23.0.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_keyring/23.0.1_x86_64/py3_keyring-23.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1bb40d7217db39f04c41bbd1e45bc95a9d3aeba2259a64fa87449fa00d4e4e6e',
     armv7l: '1bb40d7217db39f04c41bbd1e45bc95a9d3aeba2259a64fa87449fa00d4e4e6e',
     x86_64: 'f1ce83cfed4f4d7f6f0628e7022c1d9f8c1ec77a8217deed2d968075bdf4b79b'
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
