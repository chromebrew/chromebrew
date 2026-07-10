require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.45-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e5cb930a9f83086ca28eb306a8c1851154ad2101d42334f98f0264454ea1c58',
     armv7l: '2e5cb930a9f83086ca28eb306a8c1851154ad2101d42334f98f0264454ea1c58',
       i686: 'e3cc5ea4b4e3f64c5c14951822d6f99379837978a7974840d5c146e63203ec34',
     x86_64: 'e07971d32c274ab7ac2d7656f7a754fe09bd25e97c27e927e790d0b153d54261'
  })

  depends_on 'python3' => :logical

  no_source_build
end
