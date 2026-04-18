require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.91-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7023e30dede8befdbe54dd437fd215efd3a78e341fc62d5b5850e78991fc02bb',
     armv7l: '7023e30dede8befdbe54dd437fd215efd3a78e341fc62d5b5850e78991fc02bb',
       i686: '3c451e744c64f1df7b7d82953049d4952ad1594bc310f060507ec657966dcb88',
     x86_64: '433f5a7050d414e598fd85c19e4e8ecb116573961a39f6ad26ee3ead5432fa6f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
