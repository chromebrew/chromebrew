require 'package'

class Py3_semantic_version < Package
  description 'Semantic Version provides a few tools to handle SemVer in Python.'
  homepage 'https://github.com/rbarrois/python-semanticversion'
  version '2.8.5'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/rbarrois/python-semanticversion/archive/2.8.5.tar.gz'
  source_sha256 'cd50a153e3bc5a8d53b2723601532b94b23e906d82d0b07cef421945f0e02107'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
