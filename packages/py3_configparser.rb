require 'package'

class Py3_configparser < Package
  description 'Configparser backports newer configparser modules to earlier python versions.'
  homepage 'https://github.com/jaraco/configparser/'
  @_ver = '5.0.2'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jaraco/configparser.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_configparser/5.0.2-py3.11_armv7l/py3_configparser-5.0.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_configparser/5.0.2-py3.11_armv7l/py3_configparser-5.0.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_configparser/5.0.2-py3.11_i686/py3_configparser-5.0.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_configparser/5.0.2-py3.11_x86_64/py3_configparser-5.0.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fc1f3655a4ccbc93d8a2a9f1423c4ffdbbb72b104e1ae06ef218facf7b6b22d3',
     armv7l: 'fc1f3655a4ccbc93d8a2a9f1423c4ffdbbb72b104e1ae06ef218facf7b6b22d3',
       i686: 'a7a33b61709c588392d13dc444db1f54af756b3fd642c60404041d1373fcefba',
     x86_64: '89b15a470eb7e14fbca38c7fb96ab5562403e76588cb0e6eb7e8e38a67733150'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
