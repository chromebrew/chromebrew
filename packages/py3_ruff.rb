require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.9.3-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '65b3e3cae1e0feffb11e03904f0c2ccf21d66660801015bb38a578ce40bebfcd',
     armv7l: '65b3e3cae1e0feffb11e03904f0c2ccf21d66660801015bb38a578ce40bebfcd',
       i686: '925709dbf7437a093c2d3a5c581d9edc26ef12f6052a315dbccbe714cce351b7',
     x86_64: '0b1dd4cba1b6943ba492be5fdb61d762b1598e8b59077508167fc1dae651c3da'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
