require 'package'

class Py3_brotlicffi < Package
  description 'Python bindings to the Brotli compression library'
  homepage 'https://github.com/python-hyper/brotlicffi/'
  @_ver = '1.0.9.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python-hyper/brotlicffi.git'
  git_hashtag "v#{@_ver}"

  depends_on 'brotli'
  depends_on 'py3_cffi'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
