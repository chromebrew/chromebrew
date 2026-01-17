require 'buildsystems/pip'

class Py3_pyasn1 < Pip
  description 'PyASN.1 is a generic ASN.1 library for Python'
  homepage 'https://github.com/etingof/pyasn1/'
  version "0.6.2-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef2e5a7ed8b1d20f3aa88de921924c90f5f9d2ef007723fb4e669e7317bbd544',
     armv7l: 'ef2e5a7ed8b1d20f3aa88de921924c90f5f9d2ef007723fb4e669e7317bbd544',
       i686: '76f9a00d5a65822f4d5493e2b441182fbf5943ac05445842567a36b35ff5a7e0',
     x86_64: '0a9ee3d7ccb4895357fa9b63f372fef3ddccdcb4f2a787dd69fe16081b7f7ef0'
  })

  depends_on 'python3' => :build

  no_source_build
end
