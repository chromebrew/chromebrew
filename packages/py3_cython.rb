require 'package'

class Py3_cython < Package
  description 'Cython is an optimising static compiler for both the Python programming language and the extended Cython programming language.'
  homepage 'https://cython.org/'
  version '0.29.22'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/d3/38/adc49a5aca4f644e6322237089fdcf194084f5fe41445e6e632f28b32bf7/Cython-0.29.22.tar.gz'
  source_sha256 'df6b83c7a6d1d967ea89a2903e4a931377634a297459652e4551734c48195406'

  # This package needs binaries
  
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.check
    system 'python3 runtests.py'
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
