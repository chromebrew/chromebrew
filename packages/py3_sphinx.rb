require 'package'

class Py3_sphinx < Package
  description 'Sphinx is a tool that makes it easy to create intelligent and beautiful documentation'
  homepage 'http://www.sphinx-doc.org/'
  version '3.5.2'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinx/archive/v3.5.2.tar.gz'
  source_sha256 '44cb0eac9d6fa492d01e447b2e2bb1ad71d24cb09a2a4f2986a9f4f3ee6e56e7'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
