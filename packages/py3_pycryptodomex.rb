require 'buildsystems/pip'

class Py3_pycryptodomex < Pip
  description 'Pycryptodomex is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "3.22.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4b54e032c88f2d5685709cf5b523df8fb92b3a363638e8e8aadddda14445bf60',
     armv7l: '4b54e032c88f2d5685709cf5b523df8fb92b3a363638e8e8aadddda14445bf60',
       i686: '62b70a6101d6fe024720a305d45f1f848e015ef378425b7d0f87845b36b7d00f',
     x86_64: '73b1e218e97af82202881c7bf1c3a661cefdca2c0a2970490ae10483fb1b2736'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # L

  no_source_build
end
