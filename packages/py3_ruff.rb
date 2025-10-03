require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.13.3-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e9e3a154f19afc6e985a9dd2676599635230a5a28f0eedec58a12ff930dfc2e',
     armv7l: '2e9e3a154f19afc6e985a9dd2676599635230a5a28f0eedec58a12ff930dfc2e',
       i686: 'fadabb2acee0b08fc1cd04f0bc67abecc224b91afcd3a6fa0f4a44f214f4509b',
     x86_64: 'c6472a1d077898284a1e0050c0c5b994f1e55082d44fc8d8666170f15c894ba9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_maturin' => :build
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
