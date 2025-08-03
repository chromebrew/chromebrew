require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.12.7-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b6066c34be3bd8b00167e188890ec01d4f59be4a411cc71be0c556de2cc549c',
     armv7l: '8b6066c34be3bd8b00167e188890ec01d4f59be4a411cc71be0c556de2cc549c',
       i686: '8c77f7e643a07d14a2062f0446e406d18506810acf06d980f85f1442468f30c6',
     x86_64: '620b4f5f29e594b3cbc9e7f891ce8f7de18e4f9d49c746833606ff257ae2f809'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build

  no_source_build
end
