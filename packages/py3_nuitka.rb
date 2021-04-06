require 'package'

class Py3_nuitka < Package
  description 'nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version '0.6.13.2-1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/Nuitka/Nuitka/archive/0.6.13.2.tar.gz'
  source_sha256 'a594d054255688dbef8f8ba5b6cbb0207ad467384f2a6214522781ffbd5d43e5'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
