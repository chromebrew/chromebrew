require 'package'

class Py3_tox < Package
  description 'Tox aims to automate and standardize testing in python.'
  homepage 'https://tox.readthedocs.io/'
  version '3.13.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/tox-dev/tox/archive/3.13.2.tar.gz'
  source_sha256 '89967cad79e09d8e78dcfd2a43c80214048b976e1d490db6fa19d8d5968da5df'

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end

  def self.postinstall
    puts
    puts "To generate a tox.ini configuration file automatically, run 'tox-quickstart' and answer a few simple questions.".lightblue
    puts
  end
end
