require 'package'

class Py3_wcwidth < Package
  description 'Wcwidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version '0.2.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jquast/wcwidth/archive/0.2.5.tar.gz'
  source_sha256 'b08fa4c7d7be1ba86950c2d746eb0d19de80842ab7457df5b3fcd3bf52e02b08'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
