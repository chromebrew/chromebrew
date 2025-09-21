require 'buildsystems/pip'

class Py3_pyparsing < Pip
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  version "3.2.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e96304a5e4e72cfe9fdb4da1130ccacb32defc32e0ed0718b145a3c9df5880d0',
     armv7l: 'e96304a5e4e72cfe9fdb4da1130ccacb32defc32e0ed0718b145a3c9df5880d0',
       i686: '2eacefffb19fd19f19e8fe346737a5506d1748ca89ba4ee57543e5c57f8fa82d',
     x86_64: '08c0350d16b5d35ebfd9ce0fba9070c5117a0cd2ce1d868a7dc8913279cbea6e'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  no_source_build
end
