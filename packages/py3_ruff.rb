require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.12.2-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ee84d68cd33f5d74b5f8d960405ead944c45ebea3709bdd51353b49d8513c370',
     armv7l: 'ee84d68cd33f5d74b5f8d960405ead944c45ebea3709bdd51353b49d8513c370',
       i686: '65c94c9aeec7841c6521a7a96373db39d7dca7317878b3a7dfedc9c7d1ad575c',
     x86_64: '4f79d1a093cbf3af61e3f3917a6626d28729f15a0f0527f54b87f239ef6a2a00'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build

  no_source_build
end
