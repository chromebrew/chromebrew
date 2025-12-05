require 'buildsystems/pip'

class Py3_sphinxcontrib_jsmath < Pip
  description 'sphinxcontrib-jsmath is a sphinx extension which renders display math in HTML via JavaScript.'
  homepage 'https://www.sphinx-doc.org/'
  version "1.0.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
