require 'package'

class Py3_numpy < Package
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://www.numpy.org/'
  version '1.20.2'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/numpy/numpy/releases/download/v1.20.2/numpy-1.20.2.tar.gz'
  source_sha256 'c049f410c78e76ffb0af830a8afbdf8baac09897b4152b97b1a3b8345ee338ff'

  # This package needs binaries

  depends_on 'py3_setuptools' => :build
  depends_on 'py3_setuptools_cythonize' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
