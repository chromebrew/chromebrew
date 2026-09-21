require 'buildsystems/pip'

class Py3_pyparsing < Pip
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  version "3.3.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3531e74484f295fd6be9c3b11e4db4493cef11f28ed2ff657e544311048d1399',
     armv7l: '3531e74484f295fd6be9c3b11e4db4493cef11f28ed2ff657e544311048d1399',
       i686: '3a572fa1419d701405ae5214ebb71394419efd4b14f42eceb12898d6589335f7',
     x86_64: '1e42c1a0cbd5ab3a4e42c63b6cdedb0af97576e4d6640112ee11a6e4cc5b8e40'
  })

  depends_on 'py3_flit_core'
  depends_on 'python3' => :logical

  no_source_build
end
