require 'package'

class Py3_docutils < Package
  description 'Docutils is a modular system for processing documentation into useful formats.'
  homepage 'https://docutils.sourceforge.net/'
  version '0.17'
  license 'public domain, PSL, BSD-2 and GPL-3'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/docutils/files/docutils/0.17/docutils-0.17.tar.gz'
  source_sha256 'e2ffeea817964356ba4470efba7c2f42b6b0de0b04e66378507e3e2504bbff4c'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
