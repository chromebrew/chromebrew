require 'package'

class Py3_pyudev < Package
  description 'Pyudev provides python bindings for libudev.'
  homepage 'https://pyudev.readthedocs.org/'
  version '1.1.4'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/sqlalchemy/mako/archive/rel_1_1_4.tar.gz'
  source_sha256 '21a46722e5b54a0e02c6d09e3b353f025975b7da7a4a4f25d6813d84be452168'

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
