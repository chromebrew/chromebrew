require 'package'

class Py3_setuptools_cythonize < Package
  description 'The setuptools-cythonize provides distutils classes to compile Python source code into C code using Cython.'
  homepage 'https://github.com/anxuae/setuptools-cythonize/'
  version '1.0.6'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/anxuae/setuptools-cythonize/archive/1.0.6.tar.gz'
  source_sha256 'f42099807e2661ca435fdf60ded569a34fe86974876331cb179e38fe1f8328c1'

  depends_on 'py3_cython'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
