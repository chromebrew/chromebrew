require 'buildsystems/pip'

class Py3_typogrify < Pip
  description 'Typogrify provides filters to enhance web typography.'
  homepage 'https://python-markdown.github.io/'
  @_ver = '2.0.7'
  version "#{@_ver}-py3.12"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
