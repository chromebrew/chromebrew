require 'package'

class Py3_jmespath < Package
  description 'JMESPath allows you to declaratively specify how to extract elements from a JSON document.'
  homepage 'https://jmespath.org/'
  version '0.10.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jmespath/jmespath.py/archive/0.10.0.tar.gz'
  source_sha256 '999b0ef13b798cf04de5451a51201d63a6feaf07c3fdcfbab4e5bca2b4ac653e'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
