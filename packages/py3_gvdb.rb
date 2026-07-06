require 'buildsystems/pip'

class Py3_gvdb < Pip
  description 'Python client for GVDB distributed vector database'
  homepage 'https://github.com/JonathanBerhe/gvdb'
  version "0.38.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '81340591b3451384e91a40835629dc5c76e8c045d98b2c28c08bc7ca7a549f6b',
     armv7l: '81340591b3451384e91a40835629dc5c76e8c045d98b2c28c08bc7ca7a549f6b',
       i686: '747b9549d4ff9d2e4cfe7fa52fcd6c51f554d6cd4cd93b034280af8c263d0434',
     x86_64: '23534ae668b9f6ebdd3b105bbaf05989e2bc12dd6c743112a2f3e5f6e377b63e'
  })

  depends_on 'python3' => :logical

  no_source_build
end
