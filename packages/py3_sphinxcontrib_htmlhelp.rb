require 'buildsystems/pip'

class Py3_sphinxcontrib_htmlhelp < Pip
  description 'sphinxcontrib-htmlhelp is a sphinx extension which renders HTML help files.'
  homepage 'https://www.sphinx-doc.org/'
  version '2.1.0-py3.12'
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build

  no_compile_needed
end
