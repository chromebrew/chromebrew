require 'package'

class Py3_pyyaml < Package
  description 'PyYAML is a YAML parser and emitter for Python.'
  homepage 'https://pyyaml.org/'
  @_ver = '5.4.1.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/yaml/pyyaml.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/5.4.1.1_armv7l/py3_pyyaml-5.4.1.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/5.4.1.1_armv7l/py3_pyyaml-5.4.1.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyyaml/5.4.1.1_x86_64/py3_pyyaml-5.4.1.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2238a2b916934779b015e9b80279d05a0e8431580c33c97baeed732dfd97e5db',
     armv7l: '2238a2b916934779b015e9b80279d05a0e8431580c33c97baeed732dfd97e5db',
     x86_64: '2219b3b519406e57edcbd2bde7895b850b255b4a06d8d76c1e7ee8f784935e47'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
