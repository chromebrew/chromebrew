require 'buildsystems/pip'

class Py3_smartypants < Pip
  description 'Smartypants translates plain ASCII punctuation characters into "smart" typographic punctuation HTML entities.'
  homepage 'https://github.com/leohemsted/smartypants.py/'
  @_ver = '2.0.1'
  version "#{@_ver}-py3.12"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build
  no_compile_needed
end
