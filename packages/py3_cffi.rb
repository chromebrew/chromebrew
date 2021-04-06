require 'package'

class Py3_cffi < Package
  description 'cffi is a Foreign Function Interface for python calling C code.'
  homepage 'https://cffi.readthedocs.org/'
  version '1.14.5'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://foss.heptapod.net/pypy/cffi/-/archive/v1.14.5/cffi-v1.14.5.tar.bz2'
  source_sha256 'd99690c6fe2efa7b60d0abb3ea6f30fd544d15ee01909328ea2d1991939d4162'

  depends_on 'py3_pycparser'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
