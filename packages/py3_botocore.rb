require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.44.5-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '63050340864c1041ee529c1c1e273cec956b7d74a55a9fb4c0b882864efc6981',
     armv7l: '63050340864c1041ee529c1c1e273cec956b7d74a55a9fb4c0b882864efc6981',
       i686: '29812159c762cd941893167787ea7678a1e365968d49759c38155aaebd34597e',
     x86_64: 'bad4bcc7e8a9e2ef3953661653a7364545e2382f19bebee2c88262e42a47629f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
