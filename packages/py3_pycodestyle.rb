require 'package'

class Py3_pycodestyle < Package
  description 'Pycodestyle is a python style guide checker'
  homepage 'https://pycodestyle.pycqa.org/'
  version '1.7.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/PyCQA/pycodestyle/archive/1.7.1.tar.gz'
  source_sha256 'ac48ac8a27b7d184a698bfc1ba1c441dfeeac359979d71a23a9eebc131d0c6fc'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
