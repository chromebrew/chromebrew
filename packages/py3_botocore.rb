require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.32-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '805e969397a9e041d7864b596d4ae3e1ef074b1c61c174c86a91269b6d51c0cf',
     armv7l: '805e969397a9e041d7864b596d4ae3e1ef074b1c61c174c86a91269b6d51c0cf',
       i686: 'e4edbd4fb90a3062fc414242e0d24c4bc218be8a052b2ed86d84053f40956d8c',
     x86_64: '6927afd629715c12caa011b7bc7cae2452a53f99c296083008202f0cbbf0a169'
  })

  depends_on 'python3' => :logical

  no_source_build
end
