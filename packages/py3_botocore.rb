require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.44.8-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1cadcb2dcaa05452f15a4de41629d4dc41f1a8be508d193287edb58bb7d53d7d',
     armv7l: '1cadcb2dcaa05452f15a4de41629d4dc41f1a8be508d193287edb58bb7d53d7d',
       i686: '24890487d9908361980ed6d2f94eedc6b75030e81797bec46fc672d03f9fa495',
     x86_64: 'f43e46b85b997f765addbe8d6bdada05f72d5787db7ac36301baa4ce943ba80b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
