require 'buildsystems/pip'

class Py3_pyparsing < Pip
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  version "3.3.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eca019606b04d5ce8e50f23393d85c473e8ad933656d774ba8ce5070d01175f3',
     armv7l: 'eca019606b04d5ce8e50f23393d85c473e8ad933656d774ba8ce5070d01175f3',
       i686: '19cbbc2100f196d735ae5b223c80e99afc6b6e57366e4c0e35d692de504b1de3',
     x86_64: 'f083d0504b250850dee4decbcca3fde43b1275cad3f42e39f9fdada8dadf03b7'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  no_source_build
end
