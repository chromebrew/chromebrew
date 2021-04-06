require 'package'

class Py3_lunr < Package
  description 'Lunr.py is a python implementation of lunr.js'
  homepage 'https://lunr.readthedocs.io/'
  version '0.5.9'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/yeraydiazdiaz/lunr.py/archive/0.5.9.tar.gz'
  source_sha256 'e5aa714d67041a5d115d28328ecb26cc53cfa9810341c403fb62856b2bbb73a2'

  depends_on 'py3_future'
  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
