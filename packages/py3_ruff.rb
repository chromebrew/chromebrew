require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.12.3-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '283a15c99261bcbf5d9b0384ae55c9c99cbdb3a1b0a21f6c0c972bac3c1f16fa',
     armv7l: '283a15c99261bcbf5d9b0384ae55c9c99cbdb3a1b0a21f6c0c972bac3c1f16fa',
       i686: '432e5e52f12547a4390cff31e23c8f41394ae495d64fd5b9b3f88444dfa4b60b',
     x86_64: 'f0fab3b7b592b2770adbbcbf6da873757e21d5d3427070df384ff580c0e00be3'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build

  no_source_build
end
