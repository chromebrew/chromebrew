require 'buildsystems/pip'

class Py3_smartypants < Pip
  description 'Smartypants translates plain ASCII punctuation characters into "smart" typographic punctuation HTML entities.'
  homepage 'https://github.com/leohemsted/smartypants.py/'
  version "2.0.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
