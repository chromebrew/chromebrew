require 'package'

class Py3_livereload < Package
  description 'Python LiveReload is designed for web developers who know python.'
  homepage 'https://livereload.readthedocs.io/'
  version '2.6.3'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/lepture/python-livereload/archive/2.6.3.tar.gz'
  source_sha256 '1d31d598d8dea0445e5d53e592e5fce5befd2265b001ce8995462200d3d247bf'

  depends_on 'py3_six'
  depends_on 'py3_tornado'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
