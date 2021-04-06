require 'package'

class Py3_filelock < Package
  description 'FileLock implements a platform independent file lock in python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version '3.0.12'
  license 'Unlicense'
  compatibility 'all'
  source_url 'https://github.com/benediktschmitt/py-filelock/archive/v3.0.12.tar.gz'
  source_sha256 'eafca6feda88295a054ccb3276adcc8d326318b116fa5e124522dd51dd62fd56'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
