require 'package'

class Py3_yamllint < Package
  description 'YAMLlint is a linter for YAML files.'
  homepage 'https://github.com/adrienverge/yamllint/'
  @_ver = '1.26.1'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/adrienverge/yamllint.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_yamllint/1.26.1_armv7l/py3_yamllint-1.26.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_yamllint/1.26.1_armv7l/py3_yamllint-1.26.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_yamllint/1.26.1_x86_64/py3_yamllint-1.26.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '837b3fbd5de3720a73bf42449551f689715d4eca1fa652a3adeb5555bb3bd06f',
     armv7l: '837b3fbd5de3720a73bf42449551f689715d4eca1fa652a3adeb5555bb3bd06f',
     x86_64: '94658f0b7f7c2406112d4c38fa3448dc61b17c84e6c19cbcb07a90bd0cf97149'
  })

  depends_on 'py3_pathspec'
  depends_on 'py3_pyyaml'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
