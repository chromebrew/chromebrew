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
    aarch64: 'f2c444d6918895e5bb06b11b8ad895fb9d09afa69230f0197723ae9a7e75c38d',
     armv7l: 'f2c444d6918895e5bb06b11b8ad895fb9d09afa69230f0197723ae9a7e75c38d',
       i686: '3215916c0a23da2fc6cbe30e003d27aac7504c52a5c94f1fd72eed3cdddbb16c',
     x86_64: '2b67f3ad02c7647ea799588c584a3f9a37ff9d4b3dd2acda120fe19b2d6b5cfa'
  })

  depends_on 'python3' => :logical

  no_source_build
end
