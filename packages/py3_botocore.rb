require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.62-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ef68177bc2fad345770761a87642b598d22c3acafc7c42e5d6ff9c7208d243a',
     armv7l: '2ef68177bc2fad345770761a87642b598d22c3acafc7c42e5d6ff9c7208d243a',
       i686: '2c488a8573095604d400afb736340a86184f1471ea6ca99a27bea93622d0a6ea',
     x86_64: '7b8676efb12d2c373418e2409ade274541b67393ea15484b71c904069a1c1e7f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
