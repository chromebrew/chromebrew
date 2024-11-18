require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.7.4-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '16c187263b9312af0351cdf6a773276a05965b2f4c2389a4ae648882f547d81b',
     armv7l: '16c187263b9312af0351cdf6a773276a05965b2f4c2389a4ae648882f547d81b',
       i686: 'b2eb1e196324d245da96eb9ee5e7af1b1c12a77a013e3c86e66a58568f215929',
     x86_64: 'd45e72f91a23f2f5a36ba8176bbd6b41d07b28e64ea0a44f8d80c972c4e08fae'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
