require 'package'

class Py3_jmespath < Package
  description 'JMESPath is a query language for JSON.'
  homepage 'https://jmespath.org/'
  @_ver = '0.10.0'
  version @_ver + '-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jmespath/jmespath.py.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
