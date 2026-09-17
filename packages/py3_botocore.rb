require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.96-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5e36f590d3fe65ba56bf59abfeb9cd5966b349991041fc75776bc3c9bd21a24e',
     armv7l: '5e36f590d3fe65ba56bf59abfeb9cd5966b349991041fc75776bc3c9bd21a24e',
       i686: '09e7f9638e9eb9e9d8776698834e2ad88d82eac4cfa4637661ad60229e693ddb',
     x86_64: 'e0c711538f1cf6e965ba75f92df7cc7b0356d9cb42cb3b52a1f6169d0f4f32d3'
  })

  depends_on 'python3' => :logical

  no_source_build
end
