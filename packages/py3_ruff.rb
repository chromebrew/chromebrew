require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.11.0-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '312be56a4bee171401539a6e64b8ed3835334442d356ecaf38c16675a11cefcf',
     armv7l: '312be56a4bee171401539a6e64b8ed3835334442d356ecaf38c16675a11cefcf',
       i686: '0f9838407f5b51773c44769d08d1f9f9c92107b74b6628af0357c00dc16c7e93',
     x86_64: 'cb77ffbed609fad568570a63da91b8b975f2a00c6f3e6aa307d1d30023f48d6e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
