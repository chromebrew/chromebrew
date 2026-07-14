require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.47-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b0b86dcf001bae43096954d844f35f0a568dfc038f273538c8ef4c3a998eca9',
     armv7l: '3b0b86dcf001bae43096954d844f35f0a568dfc038f273538c8ef4c3a998eca9',
       i686: '828ebb62d9425bbd2bfedc2e064b2e1e02ca099992161e2eb1068d03792cd4a4',
     x86_64: '5c9d7955fed141ea419f027b6ca222b005f74e8605214797955fef0801992047'
  })

  depends_on 'python3' => :logical

  no_source_build
end
