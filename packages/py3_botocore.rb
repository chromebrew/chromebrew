require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.22-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0294d6540a596a9875a4d15a318e2cace6db69d39fbc9bea571f94ee7b158682',
     armv7l: '0294d6540a596a9875a4d15a318e2cace6db69d39fbc9bea571f94ee7b158682',
       i686: '6f8492f691a54e4f4be0e3f840515734baee332149ec5a01672e3235e114eed4',
     x86_64: '3afa13e73749cdd4b93d6637da99a78024eac9aa8c0a15ede869cd1305f4d8a1'
  })

  depends_on 'python3' => :logical

  no_source_build
end
