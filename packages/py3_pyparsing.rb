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
    aarch64: '58a93d653e04e22ac397b375654e5a2021f8c4554f2f050c4d92e2e82068fd3a',
     armv7l: '58a93d653e04e22ac397b375654e5a2021f8c4554f2f050c4d92e2e82068fd3a',
       i686: '2a3054e068bb55b94b6c34615fcaa9588b9a84ed20b4db2adc49e0c75b81f403',
     x86_64: 'c9ebbb8e175dfc55bbbc5812615179bf60cd5ae2f574ae5daad26f0ac4843faf'
  })

  depends_on 'py3_flit_core'
  depends_on 'python3' => :logical

  no_source_build
end
