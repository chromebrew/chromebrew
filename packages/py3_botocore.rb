require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.120-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eb643389d0283a9f90bbc068a061653be76b29fad25088685989c0c3d8bd2d64',
     armv7l: 'eb643389d0283a9f90bbc068a061653be76b29fad25088685989c0c3d8bd2d64',
       i686: '043e4fc95900d05a5e4cd2f2e8ba04a99974f11ac1023bf29e6425c0c098f388',
     x86_64: '3e118618bdbe7e67694351ff13994c62126bf619dcb7db04d9387c6730eaed56'
  })

  depends_on 'python3' => :logical

  no_source_build
end
