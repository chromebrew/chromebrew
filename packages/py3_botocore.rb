require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.68-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c311797b3178c157c10e07799a1bf6fac4305fa1703785b683bcb4616ec06b62',
     armv7l: 'c311797b3178c157c10e07799a1bf6fac4305fa1703785b683bcb4616ec06b62',
       i686: '57a64eb1c1217560f9fd59acdeb3832ca01ce45d2db5356e3b0478a70d43170d',
     x86_64: '3801c0d958ae29ee4901e5a6ad6b3c889ccce8c81d697c18681eb59ef5d477ce'
  })

  depends_on 'python3' => :logical

  no_source_build
end
