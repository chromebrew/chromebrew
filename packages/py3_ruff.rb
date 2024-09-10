require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version '0.6.4-py3.12'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b7aecf5d7e0d8a710bb5676ae1dbc3c87ba63dd16936be8ba3605514a0a3527b',
     armv7l: 'b7aecf5d7e0d8a710bb5676ae1dbc3c87ba63dd16936be8ba3605514a0a3527b',
       i686: '0a579cc5131dc04ce5c48e9dda0605c1975772281581319c51c13e63a82af3e4',
     x86_64: '150aa6f977c9cfd4234b4fa3123f3984dac26b4e9b064a9956a5105911caa310'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
