require 'package'

class Py3_secretstorage < Package
  description 'Python bindings to Freedesktop.org Secret Service API'
  homepage 'https://secretstorage.readthedocs.io/'
  @_ver = '3.3.1'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/mitya57/secretstorage.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_secretstorage/3.3.1_armv7l/py3_secretstorage-3.3.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_secretstorage/3.3.1_armv7l/py3_secretstorage-3.3.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_secretstorage/3.3.1_i686/py3_secretstorage-3.3.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_secretstorage/3.3.1_x86_64/py3_secretstorage-3.3.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f96796ae7c776a7826d80744760d64d91ba5594bed17125620806ae071e7450a',
     armv7l: 'f96796ae7c776a7826d80744760d64d91ba5594bed17125620806ae071e7450a',
       i686: '8effc39487d487cbc6c4d79ce6a69b5bdfd0fec9bf1af06ac65355b5e9813fd5',
     x86_64: '6907804991a9052f2a9d7fa2c472d0c407034013978cd231d3c17defa845573e'
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
