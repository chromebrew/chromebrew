require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.48-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '075192874e898ed790fba69d19b0f547ee1962ff735a2521826a18a3bfee605c',
     armv7l: '075192874e898ed790fba69d19b0f547ee1962ff735a2521826a18a3bfee605c',
       i686: 'aa8bc5e25507a39aabb8967b7e381ccab44897c49dc1728a81fd196f7faa9a9a',
     x86_64: 'd9fdc2b2c33fc630bc31a571cd8ba2c54689a74e01cb898ca5d6aecbd6aefecf'
  })

  depends_on 'python3' => :build

  no_source_build
end
