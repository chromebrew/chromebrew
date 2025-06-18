require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.12.0-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '812b8d62b81a53042ed6efdd9c845c920adae49ed9b499efb55b5f98c3c39afb',
     armv7l: '812b8d62b81a53042ed6efdd9c845c920adae49ed9b499efb55b5f98c3c39afb',
       i686: 'b00fb4ac8bd5bcc47c527c6b76561d4b6bf521c20df7fcc557c82edfec98a0c2',
     x86_64: '0a2b936c98c0bcf0dd8c3867ebcf976b5e44feb4ce99eaacb9ede7d912b3b21c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build

  no_source_build
end
