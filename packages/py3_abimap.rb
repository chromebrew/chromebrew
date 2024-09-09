require 'buildsystems/pip'

class Py3_abimap < Pip
  description 'A helper for library maintainers to use symbol versioning'
  homepage 'https://github.com/ansasaki/abimap'
  version '0.3.2-py3.12'
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ea009d7fb99a65fb73bd25973dea39e37b32301c5aaf93eba41fa6e853a89bf',
     armv7l: '2ea009d7fb99a65fb73bd25973dea39e37b32301c5aaf93eba41fa6e853a89bf',
       i686: 'd48df4f7c7d70a779db5d5404bb3ea9491533ff9530fc5dfe3d0707ffbc71a7a',
     x86_64: '9509d1d5d4c8f40b507b98572e9b2f2755100ad25eef7ab440787e076cade748'
  })

  depends_on 'python3' => :build

  no_source_build
end
