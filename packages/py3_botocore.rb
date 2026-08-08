require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.67-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5cee5440d0800f73334b3bee4932630d939100436676dc91edaf9f732f7a7fb6',
     armv7l: '5cee5440d0800f73334b3bee4932630d939100436676dc91edaf9f732f7a7fb6',
       i686: '5615c938360ba3e6ebb076361860cc9a91f25db94c03f6ea1f0f93363ad00a0c',
     x86_64: '72840885d71cdb47e936356070ff4ea722b43621a9de10e8db440c3cd761599b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
