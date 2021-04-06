require 'package'

class Py3_pyyaml < Package
  description 'PyYAML is a YAML parser and emitter for Python.'
  homepage 'https://pypi.org/project/PyYAML/'
  version '5.4.1.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/yaml/pyyaml/archive/5.4.1.1.tar.gz'
  source_sha256 'e79dbaae8d9253aad313ca68cf65193f810260fb44fe0508625c7e9561eb57f2'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
