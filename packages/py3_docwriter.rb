require 'package'

class Py3_docwriter < Package
  description 'Docwriter is the API reference documentation generator for FreeType.'
  homepage 'https://github.com/freetype/docwriter/'
  version '1.3.1'
  license 'FTL or GPL-2'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/65/19/f1c5497839c30ca23574cc82093e7ca5f8d6e8e159f819a8c65f50c78db3/docwriter-1.3.1.tar.gz'
  source_sha256 'a6dec71292d2e481b5f28be79344611fa7777cd1fcffb691439021dd72f88f10'

  depends_on 'py3_mistune'
  depends_on 'py3_mkdocs'
  depends_on 'py3_mkdocs_material'
  depends_on 'py3_pyyaml'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
