require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.11.2-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '54a9e261a0e38fbe74f2f52a02ad2e4abd31afd4fcbc14a1a2fff5742f81b54d',
     armv7l: '54a9e261a0e38fbe74f2f52a02ad2e4abd31afd4fcbc14a1a2fff5742f81b54d',
       i686: '2c9d74e5ef79a54d69e6fbb3ab53c061cfc308b1392e82de9d646af227cdc917',
     x86_64: '9c7665ac3b36491a94f1eda871b266691f2189ae0e4d064f5e2c1f002ec647dc'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
