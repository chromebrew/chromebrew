require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.123-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9a7bad2230c8f06a9e41ec563c3161491cf1b845867ee404bc3ed8561b32fbc4',
     armv7l: '9a7bad2230c8f06a9e41ec563c3161491cf1b845867ee404bc3ed8561b32fbc4',
       i686: '659446edeaa703a238dab961b6e1b8f50c22fbb9111a1d890e7530d00401e897',
     x86_64: 'fb4af2e35a0dace7ca27f39f2bafd5ea1a18bc15b127fdfe557b79b9b1383065'
  })

  depends_on 'python3' => :logical

  no_source_build
end
