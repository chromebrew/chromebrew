require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.13.2-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b5e74cb743969f7764db01d4a9d27584c9545dcf76d6dcc2f7a415a0e00a8b0',
     armv7l: '9b5e74cb743969f7764db01d4a9d27584c9545dcf76d6dcc2f7a415a0e00a8b0',
       i686: 'fc4bf55122d8b9f6a7efcfc11dcbb3283d2651aa6d4741162f39b2d049c857ef',
     x86_64: '4eda08254a660245e4cd52cf332993be02e5b15b8aef07d27ced71921cd0c084'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_maturin' => :build
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
