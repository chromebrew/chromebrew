require 'buildsystems/pip'

class Py3_sphinxcontrib_serializinghtml < Pip
  description 'sphinxcontrib-serializinghtml is a sphinx extension which outputs "serialized" HTML files (json and pickle).'
  homepage 'https://www.sphinx-doc.org/'
  version '2.0.0-py3.12'
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build

  no_compile_needed
end
