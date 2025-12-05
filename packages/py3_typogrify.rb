require 'buildsystems/pip'

class Py3_typogrify < Pip
  description 'Typogrify provides filters to enhance web typography.'
  homepage 'https://python-markdown.github.io/'
  version "2.1.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
