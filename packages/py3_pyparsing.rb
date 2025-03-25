require 'buildsystems/pip'

class Py3_pyparsing < Pip
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  version "3.2.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '55668877a115b4da2c0ce602460ed56dc77b2048818e2e3e5ef201ef4010789c',
     armv7l: '55668877a115b4da2c0ce602460ed56dc77b2048818e2e3e5ef201ef4010789c',
       i686: '219119a4a1bdd6452765caa87f59773a34b23b40131a5eb4a45c833f417c297c',
     x86_64: '743c32378010e203990ada3ee7f1969952fc81da78fbad9917f47da9fff66bd3'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  no_source_build
end
