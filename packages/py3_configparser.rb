require 'package'

class Py3_configparser < Package
  description 'Configparser backports newer configparser modules to earlier python versions.'
  homepage 'https://github.com/jaraco/configparser/'
  @_ver = '5.0.2'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jaraco/configparser.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_configparser/5.0.2-1_armv7l/py3_configparser-5.0.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_configparser/5.0.2-1_armv7l/py3_configparser-5.0.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_configparser/5.0.2-1_i686/py3_configparser-5.0.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_configparser/5.0.2-1_x86_64/py3_configparser-5.0.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '87321cac9825e1345390d0882029e6bb4d573972c032b88c52c4e9dcfc93292d',
     armv7l: '87321cac9825e1345390d0882029e6bb4d573972c032b88c52c4e9dcfc93292d',
       i686: 'ff380d4680cc7a058464f0268fdd759428e477d03295b511fc1ef235fbfcbf61',
     x86_64: '32c1efc6399b0aacb5ae68581c51b07f7ccbf9fe5e55e726fa5ac9ce8047a789'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
