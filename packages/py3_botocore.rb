require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.101-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1636d0057dbd156a22d7a46f37ff910648594932f7a889d4729b612e2c6f2582',
     armv7l: '1636d0057dbd156a22d7a46f37ff910648594932f7a889d4729b612e2c6f2582',
       i686: 'd5dd94e1283f751de94a65100dbf774e4e88d2c85eb4e56a4344d2d61580beab',
     x86_64: '2004564ce2cde753a73a13bcb06c9b1147a0d1cd4520f8ee896a66af2ad1abb2'
  })

  depends_on 'python3' => :logical

  no_source_build
end
