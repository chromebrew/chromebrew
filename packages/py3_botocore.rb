require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.29-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1220497011a91d69cbde92f7ef171a59183c69f89536a1a1acaf0a04bb98c6bf',
     armv7l: '1220497011a91d69cbde92f7ef171a59183c69f89536a1a1acaf0a04bb98c6bf',
       i686: 'a50f5433688e2a89bd0b149251b0debb645bef219c545b8a740c7ca5a98fb2bc',
     x86_64: 'cdee22e5410ebcb2aac0f10511b8d61c0c8cdd146fe5a2073c9a79c397c3744a'
  })

  depends_on 'python3' => :build

  no_source_build
end
