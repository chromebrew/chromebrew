require 'package'

class Py3_pyyaml < Package
  description 'PyYAML is a YAML parser and emitter for Python.'
  homepage 'https://pyyaml.org/'
  @_ver = '6.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/yaml/pyyaml.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/6.0_armv7l/py3_pyyaml-6.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/6.0_armv7l/py3_pyyaml-6.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/6.0_i686/py3_pyyaml-6.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/6.0_x86_64/py3_pyyaml-6.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c0bc15e713cb696128fe3e9a51f2f0f6e3fa2ab70c5bc3393bbef48cf317f82e',
     armv7l: 'c0bc15e713cb696128fe3e9a51f2f0f6e3fa2ab70c5bc3393bbef48cf317f82e',
       i686: 'f1c16002f1c66ae16879604dc83c93fdc49edc87c01e5b2e63033d728ec62440',
     x86_64: 'e9ed77702a16c383616e8f76550ea488c044736fd5f19a3f36cd53cb92882763'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
