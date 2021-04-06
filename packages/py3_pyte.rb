require 'package'

class Py3_pyte < Package
  description 'Pyte is an in memory VTXXX-compatible terminal emulator.'
  homepage 'https://pyte.readthedocs.org/'
  version '0.8.0'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/selectel/pyte/archive/0.8.0.tar.gz'
  source_sha256 '80f77a4f8a325faf761c22eb8ad597671e25d0de524c68d42dc765c52bf5be70'

  depends_on 'py3_wcwidth'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
