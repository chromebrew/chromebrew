require 'package'

class Py3_wheel < Package
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  @_ver = '0.37.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/wheel.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.37.0_armv7l/py3_wheel-0.37.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.37.0_armv7l/py3_wheel-0.37.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.37.0_i686/py3_wheel-0.37.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.37.0_x86_64/py3_wheel-0.37.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6d222ae59975a75d1a6edc521e89773cfabc744bc3d56602c780931b659f9d8b',
     armv7l: '6d222ae59975a75d1a6edc521e89773cfabc744bc3d56602c780931b659f9d8b',
       i686: 'ec1ddb5e04ff7846511532bf9d42d0b7e34913cb1b210c712df5024c58ce1cc9',
     x86_64: 'adb0a9a13abb745e0b3e664e7db95ecdbf6d79be19b7cb8a77a80132ec7410b7'
  })

  depends_on 'py3_setuptools' => :build
  depends_on 'py3_packaging'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
