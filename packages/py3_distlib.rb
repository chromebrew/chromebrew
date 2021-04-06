require 'package'

class Py3_distlib < Package
  description 'Distlib is a library which implements low-level functions that relate to packaging and distribution of Python software.'
  homepage 'https://distlib.readthedocs.io/'
  version '0.3.1'
  license 'PSL-2'
  compatibility 'all'
  source_url 'https://bitbucket.org/pypa/distlib/downloads/distlib-0.3.1.zip'
  source_sha256 'edf6116872c863e1aa9d5bb7cb5e05a022c519a4594dc703843343a9ddd9bff1'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
