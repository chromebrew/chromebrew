require 'package'

class Py3_pyyaml < Package
  description 'PyYAML is a YAML parser and emitter for Python.'
  homepage 'https://pyyaml.org/'
  @_ver = '6.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/yaml/pyyaml.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/6.0-py3.11_armv7l/py3_pyyaml-6.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/6.0-py3.11_armv7l/py3_pyyaml-6.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/6.0-py3.11_i686/py3_pyyaml-6.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/6.0-py3.11_x86_64/py3_pyyaml-6.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0b3ca833d78ecdec86d8f088e895a5afd3ea4eefd65bdd85127f9a0f698f0208',
     armv7l: '0b3ca833d78ecdec86d8f088e895a5afd3ea4eefd65bdd85127f9a0f698f0208',
       i686: '994b99b93c8dafe49d5037f9805bf8548f1f82788949ae77e175a94019c9c36a',
     x86_64: '8c265cf0aa797e72b7d92c3982f70dc155290ecf9b47a97b3968a10c3e089fb9'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
