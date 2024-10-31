require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.7.1-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ca33a4e9df3272d482c87affcbc9363e7b8e253867ed367cb2f939fbcab5a701',
     armv7l: 'ca33a4e9df3272d482c87affcbc9363e7b8e253867ed367cb2f939fbcab5a701',
       i686: '5f580ca46880d0292156cab279d9bc907f183f5dc8deb903816f96903d459cd0',
     x86_64: '29263d8544f253a2261e9c3bcf9d2277a7750162827908b269227be1de6bc2e6'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
