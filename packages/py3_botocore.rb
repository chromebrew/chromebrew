require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.103-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '863066d987bcf995c2b8e1d4fbdb9d1badd08ed314558f7f787e2a980660916d',
     armv7l: '863066d987bcf995c2b8e1d4fbdb9d1badd08ed314558f7f787e2a980660916d',
       i686: 'a728a9d415e22245f32efe71a17bde3177275fe3e304a7839cabc404c46c9825',
     x86_64: '7f0c1fc6f3aab414617338534002ad88fd8e1761bc0ae180b57dab6c6d9d291d'
  })

  depends_on 'python3' => :logical

  no_source_build
end
