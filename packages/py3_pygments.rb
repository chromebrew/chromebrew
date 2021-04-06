require 'package'

class Py3_pygments < Package
  description 'Pygments is a python syntax highlighter'
  homepage 'https://pygments.org/'
  version '2.8.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/pygments/pygments/archive/2.8.1.tar.gz'
  source_sha256 '985c9955be7314204271e55353f5eb9f1c19167836c00084770563a3b0e458cf'

  depends_on 'py3_setuptools' => :build
  
  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
