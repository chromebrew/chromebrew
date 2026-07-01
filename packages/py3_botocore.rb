require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.38-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '968fa2217880307af4cf0c41bb24a4f73e3ebe75c20a749176a86feb4c6faaea',
     armv7l: '968fa2217880307af4cf0c41bb24a4f73e3ebe75c20a749176a86feb4c6faaea',
       i686: 'a5b32f0f8a9c4589fd254949d13c2e602609a832ba17cb2d22cbbda1e428451d',
     x86_64: '4dbc9f7ab352afad8a2023a22f1f7281c322a5c11088d659bdd256e6f67aa28b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
