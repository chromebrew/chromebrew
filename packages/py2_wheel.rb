require 'package'

class Py2_wheel < Package
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  @_ver = '0.36.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/wheel.git'
  git_hashtag @_ver

  depends_on 'python2'
  depends_on 'py2_setuptools' => :build

  def self.build
    system "python2 setup.py build #{PY2_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python2 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"

    # Remove conflicting executables
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/wheel"
  end
end
