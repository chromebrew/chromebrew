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
    aarch64: 'a40ef648365a97ef38c8c77de118c5bdd314a9b62887641abd87b19d767065bb',
     armv7l: 'a40ef648365a97ef38c8c77de118c5bdd314a9b62887641abd87b19d767065bb',
       i686: 'f2126de0d8c43ebe302c8254f7d2a9b75bc53d8ccefcda5a8ff208ab9941e085',
     x86_64: 'e736652c77902d8ac2e05b11c1aff2164d8f4445a82d9a1edd75110ad2c081e4'
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
