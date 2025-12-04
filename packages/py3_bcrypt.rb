require 'buildsystems/pip'

class Py3_bcrypt < Pip
  description 'Modern password hashing for your software and your servers.'
  homepage 'https://github.com/pyca/bcrypt/'
  version "5.0.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e1f97e5a0fc81015b03e5545fb4a8c57113f135ab8f3253648b3c00cee11674',
     armv7l: '3e1f97e5a0fc81015b03e5545fb4a8c57113f135ab8f3253648b3c00cee11674',
       i686: 'ff0387d23f2fc0fb66cb893755fba552835e4dccdf33b2bb5897dcc27171cf55',
     x86_64: 'c94b08e1b5fe28e75f97bee4e9c4c8e76f5a1420b2b1a3c5771a72dada09fa06'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
