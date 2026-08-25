require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.79-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dbb1c33f7f23442d8102dc699e93b32b95ea3c2ef55aaff24ad0bebb2df75009',
     armv7l: 'dbb1c33f7f23442d8102dc699e93b32b95ea3c2ef55aaff24ad0bebb2df75009',
       i686: '482030cd026e4f6f89ec04849367b812c222725ace219621814a5d87ca2b3f8a',
     x86_64: '9a4992f982920a9007b19cd36f8c1e1a9a2fb3469d2fb5284088ae1a28d13266'
  })

  depends_on 'python3' => :logical

  no_source_build
end
