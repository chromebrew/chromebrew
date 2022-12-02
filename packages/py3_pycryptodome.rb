require 'package'

class Py3_pycryptodome < Package
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  @_ver = '3.11.0'
  version "#{@_ver}-py3.11"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'https://github.com/Legrandin/pycryptodome.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.11.0-py3.11_armv7l/py3_pycryptodome-3.11.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.11.0-py3.11_armv7l/py3_pycryptodome-3.11.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.11.0-py3.11_i686/py3_pycryptodome-3.11.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.11.0-py3.11_x86_64/py3_pycryptodome-3.11.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0819d3e884ca2d1202eba55d2b3a56c085d90e57d0a95328b1db9bd59d08ee4d',
     armv7l: '0819d3e884ca2d1202eba55d2b3a56c085d90e57d0a95328b1db9bd59d08ee4d',
       i686: '4ffcb9c0eb14bddf2ab9b0425a0cddf6b5855b8149bdd66e2868116f3addadae',
     x86_64: '35a5619fddda1ab79fd29f010f19e01255a113f6e26ac33b8038ec711977e81c'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
