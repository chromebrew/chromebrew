require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.9.4-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df1c7c6cbff9e2a050fc78cd533c6615efb0d978db3cd15f1962b31fcd5d6643',
     armv7l: 'df1c7c6cbff9e2a050fc78cd533c6615efb0d978db3cd15f1962b31fcd5d6643',
       i686: '925709dbf7437a093c2d3a5c581d9edc26ef12f6052a315dbccbe714cce351b7',
     x86_64: '0b1dd4cba1b6943ba492be5fdb61d762b1598e8b59077508167fc1dae651c3da'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
