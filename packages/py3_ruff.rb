require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.9.2-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3035314c2b0589d00e9476eefeb8ddcdc3beb8b49c351c30666c5a254cb81b0a',
     armv7l: '3035314c2b0589d00e9476eefeb8ddcdc3beb8b49c351c30666c5a254cb81b0a',
       i686: 'f7cf6af68046a3431180fa1459ddbdbbe58cefd9f516a146a21ec587d01d583a',
     x86_64: 'a845be09bc1a428a8be25333a46fe883a1e7afa2764f239d02bbaa5168e42a3a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
