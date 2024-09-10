require 'buildsystems/pip'

class Py3_ply < Pip
  description 'Python Lex/Yacc is an implementation of lex and yacc parsing tools for Python.'
  homepage 'https://www.dabeaz.com/ply/index.html'
  version '3.11-py3.12'
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build

  no_compile_needed
end
