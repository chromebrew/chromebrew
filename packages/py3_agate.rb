require 'package'

class Py3_agate < Package
  description 'Agate is a python data analysis library that is optimized for humans instead of machines.'
  homepage 'https://agate.readthedocs.io/'
  version '1.6.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate/archive/1.6.1.tar.gz'
  source_sha256 '0397d3dcc6ae78b8289294b3bca15b2a7328b9015aed8841bc650700fe2a6cad'

  depends_on 'py3_babel'
  depends_on 'py3_isodate'
  depends_on 'py3_leather'
  depends_on 'py3_parsedatetime'
  depends_on 'py3_pytimeparse'
  depends_on 'py3_slugify'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
