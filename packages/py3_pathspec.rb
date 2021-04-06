require 'package'

class Py3_pathspec < Package
  description 'Pathspec is a utility library for pattern matching of file paths.'
  homepage 'https://github.com/cpburnz/python-path-specification/'
  version '0.8.1'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/b7/64/e097eea8dcd2b2f7df6e4425fc98e7494e37b1a6e149603c31d327080a05/pathspec-0.8.1.tar.gz'
  source_sha256 '86379d6b86d75816baba717e64b1a3a3469deb93bb76d613c9ce79edc5cb68fd'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
