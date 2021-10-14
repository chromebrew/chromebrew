require 'package'

class Py3_decorator < Package
  description 'define signature-preserving function decorators and decorator factories'
  homepage 'https://github.com/micheles/decorator/'
  @_ver = '4.4.2'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/micheles/decorator.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
