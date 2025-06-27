require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.12.1-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '41f6628982d9e2e1d7df9578cfde30dbe4fce50ebdab912c96ff8f1c8a3f96d1',
     armv7l: '41f6628982d9e2e1d7df9578cfde30dbe4fce50ebdab912c96ff8f1c8a3f96d1',
       i686: 'e95be7f24bd8b4177a959f4c82d25a66a50cde5782c877c16a20e9a98b0d98c8',
     x86_64: 'a381c9f8700384120c4ee62416f34bffe59333918b0391e83686a9ef59266408'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build

  no_source_build
end
