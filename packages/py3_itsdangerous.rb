require 'package'

class Py3_itsdangerous < Package
  description 'ItsDangerous provide various helpers to pass data to untrusted environments and back.'
  homepage 'https://palletsprojects.com/p/itsdangerous/'
  @_ver = '2.0.1'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/itsdangerous.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_itsdangerous/2.0.1_armv7l/py3_itsdangerous-2.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_itsdangerous/2.0.1_armv7l/py3_itsdangerous-2.0.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_itsdangerous/2.0.1_i686/py3_itsdangerous-2.0.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_itsdangerous/2.0.1_x86_64/py3_itsdangerous-2.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e480e5ef2d9b757bbcd7b45a0427003a2d81ee85e9388f56cfc895ec6ed5d0c1',
     armv7l: 'e480e5ef2d9b757bbcd7b45a0427003a2d81ee85e9388f56cfc895ec6ed5d0c1',
       i686: '6776095190067ae1b6809aa7cb6d61f0baa08423e2bac1f4b110584d7da56600',
     x86_64: 'b211621da276c9693729ba64ab14f4a133683c2692f5b737e38ea50653adf00a'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
