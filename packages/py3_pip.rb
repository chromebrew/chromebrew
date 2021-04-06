require 'package'

class Py3_pip < Package
  description 'Pip is the Python Packaging Authority (PyPA) recommended tool for installing Python packages.'
  homepage 'https://pip.pypa.io/'
  version '21.0.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip/archive/21.0.1.tar.gz'
  source_sha256 '2522dd398be2e592d68e9be9406f7af71945bb8634e603b7e1c493b8378f3730'

  depends_on 'python3'
  depends_on 'py3_setuptools'
  depends_on 'xdg_base'

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end

  def self.postinstall
    puts
    puts "By default, pip installs packages into #{CREW_LIB_PREFIX}/python3.9/site-packages/.".lightblue
    puts "This behavior WILL conflict with Chromebrew packages.".lightblue
    puts "To avoid this behavior, we STRONGLY recommend that you append the --user flag to all".lightblue
    puts "pip3 install operations.".lightblue
    puts
  end
end
