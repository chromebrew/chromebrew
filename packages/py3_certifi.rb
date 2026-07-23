require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2026.7.22-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd96f60830d3f0672c98c6e447308e2b95de8655de74c63e0434daccc9309044d',
     armv7l: 'd96f60830d3f0672c98c6e447308e2b95de8655de74c63e0434daccc9309044d',
       i686: 'b9f16312ef35a3ceef87a8186cca748c1627f8ae49191892e7486643d25fac08',
     x86_64: '2a056bee8feeefb096d93ce35bd8678069658ba98949002ebfe12511842dc7f3'
  })

  depends_on 'python3' => :logical

  no_source_build
end
