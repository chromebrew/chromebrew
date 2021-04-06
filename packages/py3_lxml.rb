require 'package'

class Py3_lxml < Package
  description 'lxml is a Powerful and Pythonic XML processing library for python.'
  homepage 'https://lxml.de/'
  version '4.6.3'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/lxml/lxml/archive/lxml-4.6.3.tar.gz'
  source_sha256 '5955ed615b7be9407d9eab83edde8f1818c94224d762d1d6355bf0371f220bd6'

  # This package needs binaries

  depends_on 'libxml2'
  depends_on 'libxslt'
  depends_on 'py3_cssselect'
  depends_on 'py3_setuptools' => :build
  depends_on 'py3_setuptools_cythonize' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS} \
              --with-cython"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
