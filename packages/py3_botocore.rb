require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.93-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd57e972c94dae8a9203073b711718a29aa73ae3b5f78789fa49b3ba37e8e3b4e',
     armv7l: 'd57e972c94dae8a9203073b711718a29aa73ae3b5f78789fa49b3ba37e8e3b4e',
       i686: '2537654898b207dc075f91e53ecd1dafd389faec25ae852566567fd49d61dd10',
     x86_64: 'fad9aa9a2f51daf41ab3cd5b0038cdcc8fac60b867bb8a78b7c3e06cd63a8010'
  })

  depends_on 'python3' => :logical

  no_source_build
end
