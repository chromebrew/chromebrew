require 'package'

class Py2_setuptools < Package
  description 'Easily download, build, install, upgrade, and uninstall Python packages'
  homepage 'https://pypi.org/project/setuptools/'
  version '44.1.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools/archive/v44.1.0.tar.gz'
  source_sha256 '77839f3c8fec402a974afa25e2d910948c59cd6dd7dbf72e0f35e65012b01645'

  depends_on 'python27'

  def self.build
    system 'python2 bootstrap.py'
    system "python2 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python2 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
