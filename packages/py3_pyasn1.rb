require 'package'

class Py3_pyasn1 < Package
  description 'PyASN.1 is a generic ASN.1 library for Python'
  homepage 'https://github.com/etingof/pyasn1/'
  @_ver = '0.4.8'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/etingof/pyasn1.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyasn1/0.4.8_armv7l/py3_pyasn1-0.4.8-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyasn1/0.4.8_armv7l/py3_pyasn1-0.4.8-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyasn1/0.4.8_i686/py3_pyasn1-0.4.8-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyasn1/0.4.8_x86_64/py3_pyasn1-0.4.8-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '973e13b9ed9e573657b2e0d4744a59a2b184f476c3fac9444d0b04c623a81f93',
     armv7l: '973e13b9ed9e573657b2e0d4744a59a2b184f476c3fac9444d0b04c623a81f93',
       i686: '00e5fca0a064b6788ff674dfc020750af9817d30b52dc88d689d36e3da847aae',
     x86_64: '1654c19d2179c0c0a810003a29c1a55e0005c99e3bd7d64347a734806b670e70'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
