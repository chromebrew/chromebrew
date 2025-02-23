require 'buildsystems/pip'

class Py3_decorator < Pip
  description 'define signature-preserving function decorators and decorator factories'
  homepage 'https://github.com/micheles/decorator/'
  version "5.2.0-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '76a08379fd29e63919bfdb47d7feea7051be5f230346e4e2e607f1f537896f7b',
     armv7l: '76a08379fd29e63919bfdb47d7feea7051be5f230346e4e2e607f1f537896f7b',
       i686: '1f4cb729a9bf967f4ffcd66cd82be506396facee8c967c28974fd4a2c0a10c4c',
     x86_64: '097b2df5827a703e264f6955a4d7bcf8ef6dc6714513d4bfe8601fedfc0dfa96'
  })

  depends_on 'python3' => :build

  no_source_build
end
