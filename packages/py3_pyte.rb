require 'buildsystems/pip'

class Py3_pyte < Pip
  description 'PyTE is a Simple VTXXX-compatible terminal emulator.'
  homepage 'https://github.com/selectel/pyte/'
  version '0.8.2-py3.12'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6e7d036f990689a80a11d762fecdd532a980cb623a10a246d3b6ae058e421c88',
     armv7l: '6e7d036f990689a80a11d762fecdd532a980cb623a10a246d3b6ae058e421c88',
       i686: '93bd39ef2a8c79b32c08beb93e3b3c068a16ec91fb06dd0c5ef4a46e96969e47',
     x86_64: 'fb2b93f12b928dca0c4db0875e07d792db40aea89657fc3a7bfa8128c1b2ebf3'
  })

  depends_on 'py3_wcwidth'
  depends_on 'python3' => :build

  no_source_build
end
