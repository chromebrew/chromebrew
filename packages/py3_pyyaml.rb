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
    aarch64: '8afb6e9497f8f50aa25611038f9749f74dbb84a5a1dcc42c55e4a6265f1b5cc8',
     armv7l: '8afb6e9497f8f50aa25611038f9749f74dbb84a5a1dcc42c55e4a6265f1b5cc8',
       i686: '1ab3f043afa2fcc02a4fe2e9ed2b852d544f05f1742445bdb686df040b4b0617',
     x86_64: 'baf8dfcd8504ee0b2d7234c69ed9af1b50de7f28d0172d9424a27682ed1e4430'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
