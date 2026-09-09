require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.11.8-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb577c63d293254def64ca4f328ee858a8e189341a941f8317ad7abd110169f4',
     armv7l: 'fb577c63d293254def64ca4f328ee858a8e189341a941f8317ad7abd110169f4',
       i686: '5a31a22fd64a0d918149b8a6aba0c9dca0dba41c7bb5731a82923e88b1c827bf',
     x86_64: '5f9d5e3c4b9b6bd59f3b427a19765ce49071ce5fddd407fc68417ad749ec1ba6'
  })

  depends_on 'python3' => :logical

  no_source_build
end
