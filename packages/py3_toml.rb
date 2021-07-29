require 'package'

class Py3_toml < Package
  description 'Toml is a Python Library for Tom\'s Obvious, Minimal Language.'
  homepage 'https://github.com/uiri/toml/'
  @_ver = '0.10.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/uiri/toml.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_toml/0.10.2_armv7l/py3_toml-0.10.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_toml/0.10.2_armv7l/py3_toml-0.10.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_toml/0.10.2_i686/py3_toml-0.10.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_toml/0.10.2_x86_64/py3_toml-0.10.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8740f4745f1491bbeb33de0707cda75e81a4c69645914c38986841a065425400',
     armv7l: '8740f4745f1491bbeb33de0707cda75e81a4c69645914c38986841a065425400',
       i686: '374ada4e78998f7aa1e43894f1a865691b9b5e38aa21167570512fad12c56271',
     x86_64: '01e5b4d3b2213eae93985f6b2783d7f40892dc531ed9b77c936f404150c727ec'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
