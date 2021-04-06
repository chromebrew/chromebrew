require 'package'

class Py3_packaging < Package
  description 'Packaging provides core utilities for python packages.'
  homepage 'https://packaging.pypa.io/'
  version '20.9'
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/pypa/packaging/archive/20.9.tar.gz'
  source_sha256 '62feaa84fcb2157401bc27b86e8beb6d644c24c1b5c01aef0ba9ab334d6547f8'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
