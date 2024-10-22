require 'buildsystems/pip'

class Py3_psutil < Pip
  description 'psutil is a cross-platform library for process and system monitoring in Python.'
  homepage 'https://github.com/giampaolo/psutil/'
  version "6.1.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cd9bad21b8e6d4854fd7f766259b2c34d02daa980469d327b41e81074b2f312e',
     armv7l: 'cd9bad21b8e6d4854fd7f766259b2c34d02daa980469d327b41e81074b2f312e',
       i686: '9d7ac4536b6c9d11861f20c5399187af2d61f1b551e0cb740094bc9c582b028b',
     x86_64: 'b6a41647e90cf40227f6e10234aabc037f1b2c0394846d2e15ead119c2c90a66'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
