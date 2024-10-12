require 'buildsystems/pip'

class Py3_pyparsing < Pip
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  version "3.1.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a16351552ea09fc6659dc4af89f68ac55082aa9d2ba8bce966775e60a3f9711b',
     armv7l: 'a16351552ea09fc6659dc4af89f68ac55082aa9d2ba8bce966775e60a3f9711b',
       i686: 'f24620e845f22533eed7f1843385aa3d1136ed9af0c6a37bc376a7830f417bd3',
     x86_64: '54e51484646ce0ef81c7ba33f5f491f972d7705163f691b4e62eeab03b46abb4'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  no_source_build
end
