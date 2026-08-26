require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.80-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '54de5cb24d7a1730d17ca4d24ba0c42146aca1a22a35416cbfccda2f884177b7',
     armv7l: '54de5cb24d7a1730d17ca4d24ba0c42146aca1a22a35416cbfccda2f884177b7',
       i686: 'df6bdd26abf2215c1105e16bd9ac510de00d933b8f3b827c6a3e7d0572280510',
     x86_64: 'a6a51b1aab528ac9019f0aa4c3fb6830372a33f9833b9ffa39368a0217a39548'
  })

  depends_on 'python3' => :logical

  no_source_build
end
