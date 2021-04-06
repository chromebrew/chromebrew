require 'package'

class Py2_six < Package
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://six.readthedocs.io/'
  version '1.15.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/benjaminp/six/archive/1.15.0.tar.gz'
  source_sha256 '36252a752837b72f60def78bc408a05c21d22fe00a34a7dc3409d96b2c6e20c8'

  depends_on 'python27'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python2 setup.py build #{CREW_SETUP_PY2_BUILD_OPTIONS}"
  end

  def self.install
    system "python2 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
