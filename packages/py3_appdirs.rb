require 'package'

class Py3_appdirs < Package
  description 'Appdirs is a python module for determining appropriate platform-specific directories.'
  homepage 'https://github.com/ActiveState/appdirs/'
  version '1.4.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ActiveState/appdirs/archive/1.4.4.tar.gz'
  source_sha256 '6db10570b4f0176a05924c20745ff73385497e57829634fb3e756e15636ff408'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
