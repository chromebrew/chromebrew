require 'buildsystems/pip'

class Py3_sphinxcontrib_serializinghtml < Pip
  description 'sphinxcontrib-serializinghtml is a sphinx extension which outputs "serialized" HTML files (json and pickle).'
  homepage 'https://www.sphinx-doc.org/'
  version "2.0.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
