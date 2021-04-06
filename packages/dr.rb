# Note: this package is depreciated upstream

require 'package'

class Dr < Package
  description 'A simple ed-like devRant client'
  homepage 'https://github.com/Ewpratten/dr/'
  version '2.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Ewpratten/dr/archive/2.0-cros.tar.gz'
  source_sha256 '0ab9003c23d74d1ca8b0cfaf33e7db5e5b908d3448c87c4c0a83c9bf77a8ac23'

  depends_on 'py3_requests'
  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
