require 'package'

class Py2_pip < Package
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  @_ver = '20.3.4'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag @_ver

  depends_on 'python2'
  depends_on 'py2_setuptools'
  depends_on 'py2_wheel'

  def self.build
    system "python2 setup.py build #{PY2_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python2 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"

    # Don't make pip2 the default pip
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/pip" if File.exist? "#{CREW_DEST_PREFIX}/bin/pip"
  end
end
