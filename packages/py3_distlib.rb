require 'buildsystems/pip'

class Py3_distlib < Pip
  description 'Distlib provides distribution utilities for Python packages.'
  homepage 'https://bitbucket.org/pypa/distlib/'
  version "0.4.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99f26c90dd65b2b989a27cf2fd61cbff63ecb7b7766a2047277633a89ce8815d',
     armv7l: '99f26c90dd65b2b989a27cf2fd61cbff63ecb7b7766a2047277633a89ce8815d',
       i686: '1ba16c1c1fc0d7498ac118a93f76fad8edc76489f7393f1d250e86a230b493ae',
     x86_64: 'd2b9e3a35ebf3654b1e6b8c32913f25014c99b3079a380be103f59b3e5c477fd'
  })

  depends_on 'python3' => :logical

  no_source_build
end
