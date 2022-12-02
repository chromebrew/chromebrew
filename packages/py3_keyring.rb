require 'package'

class Py3_keyring < Package
  description 'Keyring stores and accesses your passwords safely.'
  homepage 'https://github.com/jaraco/keyring/'
  @_ver = '23.2.1'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jaraco/keyring.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_keyring/23.2.1-py3.11_armv7l/py3_keyring-23.2.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_keyring/23.2.1-py3.11_armv7l/py3_keyring-23.2.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_keyring/23.2.1-py3.11_i686/py3_keyring-23.2.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_keyring/23.2.1-py3.11_x86_64/py3_keyring-23.2.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0a26532eed90c1f3a638bfda7643cf70f4d013cb4282ec43e123a0a21b79fae5',
     armv7l: '0a26532eed90c1f3a638bfda7643cf70f4d013cb4282ec43e123a0a21b79fae5',
       i686: '0ceb42ee0054e124a22aedb5e44f160ea895fb19408a75f6d811c45f155bb361',
     x86_64: 'a4868ddc2f2533a9d45a3a285c8f2f500607a3dcceb4cce2fbfd4bf0682f54d7'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_secretstorage'
  depends_on 'py3_importlib_metadata'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
