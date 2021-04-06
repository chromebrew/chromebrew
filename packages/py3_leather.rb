require 'package'

class Py3_leather < Package
  description 'Slugify is a generic slugifier utility for python.'
  homepage 'http://leather.rtfd.io/'
  version '0.3.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/leather/archive/0.3.3.tar.gz'
  source_sha256 '70f621f7c5ddac6bc3261850134c0187cb200844243eb878a29f8a8f15a8db46'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
