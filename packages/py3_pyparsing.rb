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
    aarch64: '2ba8a3bc7b1f9a774c47768b0c8f84d123a3fa171a41e0901be10b2bba9f6073',
     armv7l: '2ba8a3bc7b1f9a774c47768b0c8f84d123a3fa171a41e0901be10b2bba9f6073',
       i686: 'df0d60aa4d151c7223f5ff5b28532da31337a76ce53ef394a2ae6d5bdf71e16f',
     x86_64: 'fade1fddc1561e1b82c0b443d0a294b390da3cdfdc18b62833cbe4774aacaa2b'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  no_source_build
end
