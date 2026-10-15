require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.114-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '84ea4044c8ffb29abf5ef3d1cf1e7f44f09eed5852f068ca1283f6a40b579ccc',
     armv7l: '84ea4044c8ffb29abf5ef3d1cf1e7f44f09eed5852f068ca1283f6a40b579ccc',
       i686: '3b336eebf6ce206873300ad85bc901a3325aff5ae28235c8b8ae13ad9253d354',
     x86_64: '6f52adee7f0a6f1d4d2882e7c1820c8ef9dc1d5021c351c6c5c26c16190abc3b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
