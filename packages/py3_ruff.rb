require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.11.10-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5c07e55ccfefc1bfc81c10c5520e0dab4e898754ccffb03249d537116f92ac4c',
     armv7l: '5c07e55ccfefc1bfc81c10c5520e0dab4e898754ccffb03249d537116f92ac4c',
       i686: 'da85d8136bc9506b1c53893ae5d1c879d2d28f9f8bb99db4ec7be5dbed6e9812',
     x86_64: '636a5326dad0de2883e421c02415ef6c8f777a54e699094a6537692ac8bc7687'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
