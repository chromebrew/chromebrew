require 'package'

class Py3_sortedcontainers < Package
  description 'Pycryptodomex is a cryptographic library for Python.'
  homepage 'http://www.grantjenks.com/docs/sortedcontainers/'
  @_ver = '2.3.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/grantjenks/python-sortedcontainers.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
