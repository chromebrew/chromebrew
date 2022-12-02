require 'package'

class Py3_iniconfig < Package
  description 'Iniconfig provides simple config-ini parsing.'
  homepage 'https://github.com/pytest-dev/iniconfig/'
  @_ver = '1.1.1'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/iniconfig.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_iniconfig/1.1.1-py3.11_armv7l/py3_iniconfig-1.1.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_iniconfig/1.1.1-py3.11_armv7l/py3_iniconfig-1.1.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_iniconfig/1.1.1-py3.11_i686/py3_iniconfig-1.1.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_iniconfig/1.1.1-py3.11_x86_64/py3_iniconfig-1.1.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd6caca5b6b2c23072bdb8ba29c9c4c9314505f77e29eb396494d6bb6ac38cdc7',
     armv7l: 'd6caca5b6b2c23072bdb8ba29c9c4c9314505f77e29eb396494d6bb6ac38cdc7',
       i686: 'f51feb78d998e1d7c260272479428dd5a1cea6acac52f4acbe8257e04f741e29',
     x86_64: '18b05b6e41419244e80b3de06ab40597cb1d503f178dbbdd91ae5b427877eb3a'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
