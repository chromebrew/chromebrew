require 'package'

class Py3_iniconfig < Package
  description 'Iniconfig provides simple config-ini parsing.'
  homepage 'https://github.com/pytest-dev/iniconfig/'
  @_ver = '1.1.1'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/iniconfig.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_iniconfig/1.1.1-1_armv7l/py3_iniconfig-1.1.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_iniconfig/1.1.1-1_armv7l/py3_iniconfig-1.1.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_iniconfig/1.1.1-1_i686/py3_iniconfig-1.1.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_iniconfig/1.1.1-1_x86_64/py3_iniconfig-1.1.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5f0a8f0b2cbf53083880fa14d07fe757cc8446e748bedc46c9f7df7ebc8cc782',
     armv7l: '5f0a8f0b2cbf53083880fa14d07fe757cc8446e748bedc46c9f7df7ebc8cc782',
       i686: 'efbd07d466d50fd24574664166936e35ac77179ccbb82c8fe3e9787f84a0a35f',
     x86_64: '2ec068e5852853d383a90b9a35f3547c3ca76671cb932eb0625e183abe9c2d61'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
