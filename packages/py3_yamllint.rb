require 'package'

class Py3_yamllint < Package
  description 'YAMLlint is a linter for YAML files.'
  homepage 'https://github.com/adrienverge/yamllint/'
  @_ver = '1.26.3'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/adrienverge/yamllint.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_yamllint/1.26.3_armv7l/py3_yamllint-1.26.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_yamllint/1.26.3_armv7l/py3_yamllint-1.26.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_yamllint/1.26.3_i686/py3_yamllint-1.26.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_yamllint/1.26.3_x86_64/py3_yamllint-1.26.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5a8d289862914e1222dd1af691c929795435871a7143e694420854c9d7170cb4',
     armv7l: '5a8d289862914e1222dd1af691c929795435871a7143e694420854c9d7170cb4',
       i686: 'e386a4975dc95c65cc6350f9afdc2e4cc4ec8da4e4bfb39d7e367a3599787ee0',
     x86_64: '22405702c7dd3e4d6e11e944c5c8d610784cd5c5cbec8da7d5e86a90f9cd147e'
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
