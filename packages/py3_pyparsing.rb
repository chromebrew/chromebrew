require 'buildsystems/pip'

class Py3_pyparsing < Pip
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  version "3.3.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b14bebbfa1969d37cebf67b3ea07f08400cafc34e9dac3c3a4dda0af02af1b26',
     armv7l: 'b14bebbfa1969d37cebf67b3ea07f08400cafc34e9dac3c3a4dda0af02af1b26',
       i686: '78b009292de6fe210349e1553fe67849cfa8f552fd881fad2250d60c91c32127',
     x86_64: '78672f30aa562db72bb4f1330bde09dab05e856e8c824cff6e90c978fd915d84'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  no_source_build
end
