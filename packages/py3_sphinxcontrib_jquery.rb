require 'buildsystems/pip'

class Py3_sphinxcontrib_jquery < Pip
  description 'Extension to include jQuery on newer Sphinx releases'
  homepage 'https://www.sphinx-doc.org/'
  version "4.1-#{CREW_PY_VER}"
  license '0BSD'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :logical

  no_compile_needed
end
