require 'package'

class Py3_mkdocs_material_extensions < Package
  description 'MkDocs Material Extensions provides markdown extension resources for MkDocs Material.'
  homepage 'https://github.com/facelessuser/mkdocs-material-extensions/'
  version '1.0.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/facelessuser/mkdocs-material-extensions/archive/1.0.1.tar.gz'
  source_sha256 'a7b9eb8aea9114100f416c3f294385f0bc86f2b1ba3d78f039e2480bc981e2c0'

  depends_on 'py3_mkdocs_material'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
