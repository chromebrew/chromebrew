require 'buildsystems/pip'

class Py3_sphinxcontrib_qthelp < Pip
  description 'sphinxcontrib-qthelp is a sphinx extension which outputs QtHelp document.'
  homepage 'https://www.sphinx-doc.org/'
  version "2.0.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
