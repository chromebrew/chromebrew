require 'package'

class Py3_future < Package
  description 'future is the missing compatibility layer between Python 2 and Python 3.'
  homepage 'http://python-future.org/'
  version '0.18.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/PythonCharmers/python-future/archive/v0.18.2.tar.gz'
  source_sha256 '43c1feae4170742671ffef900acd5dbe7c72099aa602d58e95e22c2174edd057'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
