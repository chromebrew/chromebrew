require 'package'

class Py3_tornado < Package
  description 'Tornado is a Python web framework and asynchronous networking library.'
  homepage 'https://www.tornadoweb.org/'
  version '6.1.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/tornadoweb/tornado/archive/v6.1.0.tar.gz'
  source_sha256 '53a4300b786998c516fcacb76a00db6200829bf1d9b8d57e3c150bfd262e2bc8'

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
