require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.85-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f7417b5f4b480fab0fb9d9e9a9ab149da7910a461fd398e946844a42df4ba0e',
     armv7l: '9f7417b5f4b480fab0fb9d9e9a9ab149da7910a461fd398e946844a42df4ba0e',
       i686: 'b805019e5759734b621e8ccd48ca71f34549b5b2b967186ee7751588d6c2a5dc',
     x86_64: '3dc868b8693a57616ebb364a03784be4bf4498fc777aef4bc8957cee0fabfd94'
  })

  depends_on 'python3' => :logical

  no_source_build
end
