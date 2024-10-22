require 'buildsystems/pip'

class Py3_pyparsing < Pip
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  version "3.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3990fb5fe628edd46fd128c1fe5ac0735247b2b0690af32bab401d8668b1a52f',
     armv7l: '3990fb5fe628edd46fd128c1fe5ac0735247b2b0690af32bab401d8668b1a52f',
       i686: '4830dd9c90f5e59f23cf2f306e678a7f3bb1e363c730e0a884418cd0ef24f1d0',
     x86_64: '62f56649660855f8f2b8d4a400a099d570036bbc3395aad0d49ee8f166db3a0b'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  no_source_build
end
