require 'package'

class Py3_iniconfig < Package
  description 'Iniconfig is brain-dead simple config-ini parsing.'
  homepage 'https://github.com/RonnyPfannschmidt/iniconfig/'
  version '1.1.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/iniconfig/archive/v1.1.1.tar.gz'
  source_sha256 'a4489e91242e035cb58700d9a3c4bf49e0b106a85fefefe48025e333ea5ee49c'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
