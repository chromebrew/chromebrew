require 'package'

class Py3_secretstorage < Package
  description 'Python bindings to Freedesktop.org Secret Service API'
  homepage 'https://secretstorage.readthedocs.io/'
  @_ver = '3.3.1'
  version "#{@_ver}-1"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/mitya57/secretstorage.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_secretstorage/3.3.1_armv7l/py3_secretstorage-3.3.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_secretstorage/3.3.1_armv7l/py3_secretstorage-3.3.1-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_secretstorage/3.3.1-1_i686/py3_secretstorage-3.3.1-1-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_secretstorage/3.3.1-1_x86_64/py3_secretstorage-3.3.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f96796ae7c776a7826d80744760d64d91ba5594bed17125620806ae071e7450a',
     armv7l: 'f96796ae7c776a7826d80744760d64d91ba5594bed17125620806ae071e7450a',
    i686: '5394e8ae99b6c02a89ab2ebc9fb08b4661e6307cf49cc4c612aca502023831c1',
  x86_64: '7ff3c5a2f35c68d1245099237d578e79e4714f8fe220a398407ef25b6a898486'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_cryptography'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
