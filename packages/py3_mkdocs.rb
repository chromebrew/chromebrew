require 'package'

class Py3_mkdocs < Package
  description 'Docwriter is the API reference documentation generator for FreeType.'
  homepage 'https://www.mkdocs.org/'
  version '1.1.2'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/mkdocs/mkdocs/archive/1.1.2.tar.gz'
  source_sha256 '5b37a489e3d8873d038020fb839a21f3dd9f5bbac6fcbbeec61baa7a85c9abc1'

  depends_on 'py3_click'
  depends_on 'py3_lunr'
  depends_on 'py3_livereload'
  depends_on 'py3_jinja2'
  depends_on 'py3_markdown'
  depends_on 'py3_pyyaml'
  depends_on 'py3_tornado'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
