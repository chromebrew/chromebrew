require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.7.9-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'edb03fccbae45f0cc221292e23298569abca4804692a5e740fdc9da3e25e838e',
     armv7l: 'edb03fccbae45f0cc221292e23298569abca4804692a5e740fdc9da3e25e838e',
       i686: '78d35b1f15c9ea86b50efca947685f56bc6b5ac1ca23f714f3ac51db823c36db',
     x86_64: 'a1481c6de615ba88940f50a68113e637fbfeadeff0ed685b04c8aa555af66ae8'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
