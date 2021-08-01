require 'package'

class Py3_snowballstemmer < Package
  description 'Snowball stemming library collection for Python'
  homepage 'https://snowballstem.org'
  version '2.1.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://pypi.python.org/packages/source/s/snowballstemmer/snowballstemmer-2.1.0.tar.gz'
  source_sha256 'e997baa4f2e9139951b6f4c631bad912dfd3c792467e2f03d7239464af90e914'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_snowballstemmer/2.1.0_armv7l/py3_snowballstemmer-2.1.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_snowballstemmer/2.1.0_armv7l/py3_snowballstemmer-2.1.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_snowballstemmer/2.1.0_x86_64/py3_snowballstemmer-2.1.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f6a3a2ba2d0868c407a99d73e1abdc0c10a737810ed533a896158c0c55812550',
     armv7l: 'f6a3a2ba2d0868c407a99d73e1abdc0c10a737810ed533a896158c0c55812550',
     x86_64: 'b6c0bfcb4e3ac932ce270daeee1e3ded5e2c65051aaa8297abc242695317b6e2'
  })

  depends_on 'py3_pystemmer'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
