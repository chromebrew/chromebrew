require 'package'

class Py3_urllib3 < Package
  description 'urllib3 is a powerful, user-friendly HTTP client for Python.'
  homepage 'https://urllib3.readthedocs.io/'
  version '1.26.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/urllib3/urllib3/releases/download/1.26.4/urllib3-1.26.4.tar.gz'
  source_sha256 'e7b021f7241115872f92f43c6508082facffbd1c048e3c6e2bb9c2a157e28937'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
