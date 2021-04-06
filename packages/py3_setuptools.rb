require 'package'

class Py3_setuptools < Package
  description 'Easily download, build, install, upgrade, and uninstall Python packages'
  homepage 'https://pypi.org/project/setuptools/'
  version '54.2.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools/archive/v54.2.0.tar.gz'
  source_sha256 '06824a7087a5212088a11633801fdd71e2800dd6f9d777945da0249297215b10'

  depends_on 'python3'

  def self.build
    system 'python3 bootstrap.py'
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
