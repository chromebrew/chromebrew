require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.86-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2f1bfd6ae209be25ea5a16952fc1836f67dcf79313f9c8a83d27fc5aac60ca04',
     armv7l: '2f1bfd6ae209be25ea5a16952fc1836f67dcf79313f9c8a83d27fc5aac60ca04',
       i686: '476af9da924a5a6a6b2532f1d13a5ba414732553fa621197c3d121373d939611',
     x86_64: 'ccc3a05e4f55e31cfdc5fa39e8c9d86c45e2318e46e50ecc3db73406949aa675'
  })

  depends_on 'python3' => :logical

  no_source_build
end
