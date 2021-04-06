require 'package'

class Py3_pyelftools < Package
  description 'Pure-Python library for parsing and analyzing ELF files and DWARF debugging information.'
  homepage 'https://github.com/eliben/pyelftools/'
  version '0.27-1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/eliben/pyelftools/archive/v0.27.tar.gz'
  source_sha256 '2958edd7c32909f1d541b8122797fee903db700d02d168b2789aa6b667fc4a30'

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
