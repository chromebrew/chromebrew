require 'package'

class Py3_pyasn1 < Package
  description 'PyASN.1 is a generic ASN.1 library for Python'
  homepage 'https://github.com/etingof/pyasn1/'
  @_ver = '0.4.8'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/etingof/pyasn1.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
