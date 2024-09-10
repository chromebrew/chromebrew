require 'buildsystems/pip'

class Py3_typogrify < Pip
  description 'Typogrify provides filters to enhance web typography.'
  homepage 'https://python-markdown.github.io/'
  version '2.0.7-py3.12'
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build

  no_compile_needed
end
