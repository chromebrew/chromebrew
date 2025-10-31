require 'buildsystems/pip'

class Py3_pygments < Pip
  description 'Python Syntax Highlighter'
  homepage 'https://pygments.org/'
  version "2.19.2-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '899c45f0515d554b98486326e3036b2bee9098251b0ec6d1b58c91d621db1008',
     armv7l: '899c45f0515d554b98486326e3036b2bee9098251b0ec6d1b58c91d621db1008',
       i686: '744b54808941882320ed2d9c56d9a963d5c287415bd83d7519739ed4a0aa0c61',
     x86_64: 'b18ebc9e8d1ed9bb62c58cfa1498ac6e51701936b29743e22ce79842772446c2'
  })

  depends_on 'python3' => :build

  no_source_build
end
