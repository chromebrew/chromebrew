require 'package'

class Py3_pycryptodome < Package
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  @_ver = '3.11.0'
  version @_ver
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'https://github.com/Legrandin/pycryptodome.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.11.0_armv7l/py3_pycryptodome-3.11.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.11.0_armv7l/py3_pycryptodome-3.11.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.11.0_x86_64/py3_pycryptodome-3.11.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '435a62001b83311c45bed96d3b9d2866152b849f1b28ed2d219f6abecdecb60f',
     armv7l: '435a62001b83311c45bed96d3b9d2866152b849f1b28ed2d219f6abecdecb60f',
     x86_64: 'cc486ec9c6b439229a35b0790e7979b3c771658c99d00963aeb9116d87867ed9'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
