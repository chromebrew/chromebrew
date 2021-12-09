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
    aarch64: 'c6d4fab803f6ddecd92e5ebf484fd54ccc727ee8aa4617b3ca9cd4b12e156eea',
     armv7l: 'c6d4fab803f6ddecd92e5ebf484fd54ccc727ee8aa4617b3ca9cd4b12e156eea',
       i686: 'dc8c74053c80fbdfa70792b48876e246203d0be6436597e7431c7dc2cf634ccf',
     x86_64: '93abb48cfe1924845ad5cd5eb1a8cba5ed9f7f5539c7d710da08ef094ac59beb'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
