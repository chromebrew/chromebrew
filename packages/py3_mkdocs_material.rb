require 'package'

class Py3_mkdocs_material < Package
  description 'MkDocs material is a material design theme for MkDocs.'
  homepage 'https://squidfunk.github.io/mkdocs-material/'
  version '7.1.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/squidfunk/mkdocs-material/archive/7.1.0.tar.gz'
  source_sha256 '251e046a0a45942ec725acd9fc914991010a7618eb2ab5b78724488d1a8e8ada'

  depends_on 'py3_mkdocs_material_extensions'
  depends_on 'py3_mkdocs'
  depends_on 'py3_pymdown_extensions'
  depends_on 'py3_markdown'
  depends_on 'py3_pygments'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
