require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version '0.6.4-py3.12'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build
end
