require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.87-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ddc5f28bede689652fd827b1fc8a0f8e66ed8585d82d79d7e514246ba782071',
     armv7l: '4ddc5f28bede689652fd827b1fc8a0f8e66ed8585d82d79d7e514246ba782071',
       i686: '0cc8135034b19037e144c46583d3df85856c715be48917b80a11cb522ab4e9e4',
     x86_64: '5779a4d5327ed72d72f71736acbc02bb73f5dc1e82b05359d9b619ed7fd0994e'
  })

  depends_on 'python3' => :logical

  no_source_build
end
