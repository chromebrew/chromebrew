require 'buildsystems/pip'

class Py3_sphinxcontrib_devhelp < Pip
  description 'Sphinxcontrib-devhelp is a sphinx extension which outputs a Devhelp document.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.2-883c'
  version "#{@_ver}-py3.12"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
