require 'package'

class Py3_numpy < Package
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  @_ver = '1.21.2'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/numpy/numpy.git'
  git_hashtag "v#{@_ver}"

  depends_on 'lapack'
  depends_on 'py3_cython' => :build
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
