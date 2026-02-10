require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.45-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f81bb1b6c316694555993112bfad6db0bcbc10eb5db33f8a08b92022f9db4bf',
     armv7l: '5f81bb1b6c316694555993112bfad6db0bcbc10eb5db33f8a08b92022f9db4bf',
       i686: '60ba0e1024038fcdeb68a661fa3f5adc0b1e33eab28a58554e2510bd3c8dd570',
     x86_64: '4a44eab7d82a4ba819a805378c6159d1c74b1ed9d9ab1a1f0ffc22254ffa4b52'
  })

  depends_on 'python3' => :build

  no_source_build
end
