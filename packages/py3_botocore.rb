require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.41-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59647ad215cd0b343e028b6b3b382d62c3397885e5c6af9f34f4790c895cbd70',
     armv7l: '59647ad215cd0b343e028b6b3b382d62c3397885e5c6af9f34f4790c895cbd70',
       i686: '01d4eac7c46e16664cf6b31a0fa0dad75bdf44da4ce53b307f48e55f1196347c',
     x86_64: 'ce5713c008fc54f9c1d6ae8f361719f4b550c4561b40eedb296bd78f2e07fd87'
  })

  depends_on 'python3' => :logical

  no_source_build
end
