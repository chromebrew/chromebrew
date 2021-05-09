require 'package'

class Py3_yamllint < Package
  description 'YAMLlint is a linter for YAML files.'
  homepage 'https://github.com/adrienverge/yamllint/'
  @_ver = '1.26.1'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/adrienverge/yamllint.git'
  git_hashtag 'v' + @_ver

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
