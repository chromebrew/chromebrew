# NOTE: This package is depreciated upstream. Oracle's CLI requires this, but try not to make other packages depend on this.

require 'package'

class Py3_terminaltables < Package
  description 'Terminaltables allows you to easily draw tables in terminal/console applications.'
  homepage 'https://robpol86.github.io/terminaltables/'
  version '3.1.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Robpol86/terminaltables/archive/v3.1.0.tar.gz'
  source_sha256 'c02ecf68e22374ca8226d2af314875489e59d523ebec6a363a554e4716a84723'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
