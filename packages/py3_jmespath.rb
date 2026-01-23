require 'buildsystems/pip'

class Py3_jmespath < Pip
  description 'JMESPath is a query language for JSON.'
  homepage 'https://jmespath.org/'
  version "1.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bb9fde7bfe386df453dbade0c655bf323871cb1a7e377317bae43dab43b33b0e',
     armv7l: 'bb9fde7bfe386df453dbade0c655bf323871cb1a7e377317bae43dab43b33b0e',
       i686: '87616857c85d6cd7dd84d5b1a2b783fde157c1f9842db9f78030c9b6baea8c70',
     x86_64: 'ad13f08015ae5030415dd26f6464cc8602185ab56d6ecd25b65d79d84420af87'
  })

  depends_on 'python3' => :build

  no_source_build
end
