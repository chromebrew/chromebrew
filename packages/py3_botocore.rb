require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.28-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6e9357984540b059c084a4488b9ca66129581a0a79b41fb17662ae46cbc44864',
     armv7l: '6e9357984540b059c084a4488b9ca66129581a0a79b41fb17662ae46cbc44864',
       i686: '5db156f20751aedc21493b642cfb7ec037f5981e231cb103c6cb3c4994b156c4',
     x86_64: 'c6757dd54721b0b1c4993de12eaea4c4d8159dc2cfec4457cfacf0b597972695'
  })

  depends_on 'python3' => :build

  no_source_build
end
