require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.85-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e03ee7b2821eff14b869eab8b1ba72cdfe2f14dc665310b51cb0fdaf45088d63',
     armv7l: 'e03ee7b2821eff14b869eab8b1ba72cdfe2f14dc665310b51cb0fdaf45088d63',
       i686: '0f9f14d8302a27b82d9e537e939c6662fa84611422aa9c79b0e9d6519667cb2e',
     x86_64: 'd8d703bd69868ebdced0115c7b38091d4a46b6702b5b4882bc7292fe3da0e1cb'
  })

  depends_on 'python3' => :logical

  no_source_build
end
