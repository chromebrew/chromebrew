require 'package'

class Py3_pycryptodome < Package
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  @_ver = '3.10.1'
  version @_ver
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'https://github.com/Legrandin/pycryptodome.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.10.1_armv7l/py3_pycryptodome-3.10.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.10.1_armv7l/py3_pycryptodome-3.10.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.10.1_i686/py3_pycryptodome-3.10.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.10.1_x86_64/py3_pycryptodome-3.10.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1a41505f8037649f2d50514b71c9ed449c499ecd287031f5063ed0442e2d4e2e',
     armv7l: '1a41505f8037649f2d50514b71c9ed449c499ecd287031f5063ed0442e2d4e2e',
       i686: '8ad84664a25f52aa6496b61de8e97069b26e648da25bebf2acd5f887920c9b5e',
     x86_64: 'b6461c2659331ec4748d0f8209ba9e89695d3edfbd9ff03aac4f68e706b2c43f'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
