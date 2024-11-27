require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.8.0-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '38a89f0f2402fec33458aba7cb55615276b00f88ee91ac9dbb13d3dfebb53d89',
     armv7l: '38a89f0f2402fec33458aba7cb55615276b00f88ee91ac9dbb13d3dfebb53d89',
       i686: 'b2eb1e196324d245da96eb9ee5e7af1b1c12a77a013e3c86e66a58568f215929',
     x86_64: 'e2ae6dfebfae94eec278924c2bb112244b5bfad7ecfdd7924d22d87c7386c470'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
