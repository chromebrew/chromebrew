require 'buildsystems/pip'

class Py3_pyparsing < Pip
  description 'The pyparsing module is an alternative approach to creating and executing simple grammars, vs. the traditional lex/yacc approach, or the use of regular expressions.'
  homepage 'https://github.com/pyparsing/pyparsing/'
  version '3.1.4-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4dd0a9b135f8ab442a44f36a578fb921433f80ad476cf5ed58e03f481e51fb27',
     armv7l: '4dd0a9b135f8ab442a44f36a578fb921433f80ad476cf5ed58e03f481e51fb27',
       i686: 'dfb860fe25cfce007b301178e41ae21beaf0580945921375c10c5e0977269fe1',
     x86_64: '686e725272efb2aa6840d1c6bb04312b29d1f37b163cacd32c4f4f104f2d42cc'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  no_source_build
end
