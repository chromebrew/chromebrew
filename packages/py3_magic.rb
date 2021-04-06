require 'package'

class Py3_magic < Package
  description 'Python magic provides file type identification using libmagic.'
  homepage 'https://github.com/ahupp/python-magic/'
  version '0.4.22'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ahupp/python-magic/archive/0.4.22.tar.gz'
  source_sha256 'cd4be7884304720a59e72a32e578c0fe676e4cdd2664778ba105469b4c201189'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
