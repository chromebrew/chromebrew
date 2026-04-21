require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.92-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '08eeffb51562eea4d123e9dc61f7f6d26b12516cff32cd92d38323e101c5da7d',
     armv7l: '08eeffb51562eea4d123e9dc61f7f6d26b12516cff32cd92d38323e101c5da7d',
       i686: '0e411cd0f88fb9edaa5123ed9edb9c00477f751d4cc573e83ca2690dde5fae7a',
     x86_64: '3724a847b540d7ca56d09e9df5bcd0d12fa1e1cc37deb9ec81e4f429184dfe75'
  })

  depends_on 'python3' => :logical

  no_source_build
end
