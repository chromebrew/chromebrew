require 'buildsystems/pip'

class Py3_pyparsing < Pip
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  version "3.2.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9dae140714233b3844dbd2f61cd99bec2a0922401fd69dea689a421aea743935',
     armv7l: '9dae140714233b3844dbd2f61cd99bec2a0922401fd69dea689a421aea743935',
       i686: 'b35de431b868fbc38596e22b8b28de2f8019e906fa737c0766013c039139cd6e',
     x86_64: 'b1e886ad8a9af5bcafeb00e2653f86cabaa9ec93e757ff1a3bf9853ffb26b3f4'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  no_source_build
end
