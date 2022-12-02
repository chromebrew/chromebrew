require 'package'

class Py3_secretstorage < Package
  description 'Python bindings to Freedesktop.org Secret Service API'
  homepage 'https://secretstorage.readthedocs.io/'
  @_ver = '3.3.1'
  version "#{@_ver}-py3.11"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/mitya57/secretstorage.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_secretstorage/3.3.1-py3.11_armv7l/py3_secretstorage-3.3.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_secretstorage/3.3.1-py3.11_armv7l/py3_secretstorage-3.3.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_secretstorage/3.3.1-py3.11_i686/py3_secretstorage-3.3.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_secretstorage/3.3.1-py3.11_x86_64/py3_secretstorage-3.3.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8ecd6a14cd495af95f36dc15d1c4fe9654604f373a0990c351dc1c78c0349781',
     armv7l: '8ecd6a14cd495af95f36dc15d1c4fe9654604f373a0990c351dc1c78c0349781',
       i686: '5b54242768f689250329133b49322e88e75ebfcf3ba406edd1416f1f022659c5',
     x86_64: '2929955078389d80d6a83c623dc9ac0ce924793b17f0ab098078601019de9ebd'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_cryptography'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
