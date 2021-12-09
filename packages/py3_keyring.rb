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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_keyring/23.2.1_armv7l/py3_keyring-23.2.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_keyring/23.2.1_armv7l/py3_keyring-23.2.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_keyring/23.2.1_i686/py3_keyring-23.2.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_keyring/23.2.1_x86_64/py3_keyring-23.2.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'bd23a182750bc88c88fb5695c44f078d0f347b79a037ced592b9cdc9f9f07908',
     armv7l: 'bd23a182750bc88c88fb5695c44f078d0f347b79a037ced592b9cdc9f9f07908',
       i686: 'd84f9df9bebe6cf332a167d45f4c636e9ac87b178bb75a2e3e692a55205bcec7',
     x86_64: '3559dc410dc54169b88029dc2fa54d01b96fc66cf27b27196fd072eef61d0bed'
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
