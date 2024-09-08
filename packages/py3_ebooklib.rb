require 'buildsystems/pip'

class Py3_ebooklib < Pip
  description 'Ebooklib is a Python E-book library for handling books in EPUB2/EPUB3 format.'
  homepage 'https://docs.sourcefabric.org/projects/ebooklib/'
  version "#{@_ver}-py3.12"
  license 'AGPL-3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_lxml'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_compile_needed
end
