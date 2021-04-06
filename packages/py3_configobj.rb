require 'package'

class Py3_configobj < Package
  description 'Configobj provides tools for config file reading, writing and validation.'
  homepage 'https://configobj.readthedocs.io/'
  version '5.0.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/DiffSK/configobj/archive/v5.0.6.tar.gz'
  source_sha256 '2e140354efcca6f558ff9ee941b435ae09a617bc071797bef62c8d6ed2033d5e'

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
