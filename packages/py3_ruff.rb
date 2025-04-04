require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.11.3-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '54a9e261a0e38fbe74f2f52a02ad2e4abd31afd4fcbc14a1a2fff5742f81b54d',
     armv7l: '54a9e261a0e38fbe74f2f52a02ad2e4abd31afd4fcbc14a1a2fff5742f81b54d',
       i686: 'f6a1ea4a9ac87ece4a20878c6d21a311fbae56df1d4d8b36e1f677dbd6962de0',
     x86_64: 'e8379866525d78ca7d419f42b5ee48735573d6c54388620a823a9528cc871d52'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
