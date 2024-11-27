require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.24.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26ddb80e2fefc6f481a31a3990649bc136247712e7d5e96b47fb6b1f8b76defa',
     armv7l: '26ddb80e2fefc6f481a31a3990649bc136247712e7d5e96b47fb6b1f8b76defa',
       i686: '3f3103ac0426b7d662842c49465cfbae462c5080b19d6a0b42d15f23bc1da4e5',
     x86_64: '2823030080124405e75fcf504bd500dc725b9dd0c7a63f79ef09b75553a3ad07'
  })

  depends_on 'python3' => :build

  no_source_build
end
