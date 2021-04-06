require 'package'

class Py3_yamllint < Package
  description 'Yamllint is a linter for YAML files.'
  homepage 'https://github.com/adrienverge/yamllint/'
  version '1.26.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/adrienverge/yamllint/archive/v1.26.0.tar.gz'
  source_sha256 '9794d6b9bf3b84bc15c526a77e02e1aeb8313d8743f6fc01ef3970673f557d49'

  depends_on 'py3_pathspec'
  depends_on 'py3_pyyaml'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
