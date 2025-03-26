require 'buildsystems/pip'

class Py3_pyparsing < Pip
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  version "3.2.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f50f8c45cc100f9e067feb5743318795265e88ff2dfcb714859671d391cef083',
     armv7l: 'f50f8c45cc100f9e067feb5743318795265e88ff2dfcb714859671d391cef083',
       i686: '9960e5e40e2bed14ac9b7a17ab0dffdd2a23f29c3569db45adfa75bdb60dab79',
     x86_64: '67dc5f7ed2f42e7849e9c03fc261f620ef15cfd27e461f3d02b19d97733ffece'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  no_source_build
end
