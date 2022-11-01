require 'package'

class Py3_pyxdg < Package
  description 'PyXDG contains implementations of freedesktop.org standards in python.'
  homepage 'https://freedesktop.org/wiki/Software/pyxdg/'
  @_ver = '0.28'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/takluyver/pyxdg.git'
  git_hashtag "rel-#{@_ver}"

  depends_on 'py3_setuptools' => :build

  no_compile_needed

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
