require 'package'

class Py3_chump < Package
  description 'Chump is a fully featured API wrapper for Pushover.'
  homepage 'https://github.com/karanlyons/chump/'
  version '1.6.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/karanlyons/chump/archive/1.6.0.tar.gz'
  source_sha256 '0194866f57b8e0f0e3ec30a30926ed87505963bf020ba930a6b33f186b3eb780'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
