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
    aarch64: '65b3e3cae1e0feffb11e03904f0c2ccf21d66660801015bb38a578ce40bebfcd',
     armv7l: '65b3e3cae1e0feffb11e03904f0c2ccf21d66660801015bb38a578ce40bebfcd',
       i686: '6500b74a8cfc87a607417dd68b9e508d62566864f9629a89ed024b669d55103d',
     x86_64: '1f1e0ae0d4a3e0c0ac31ef8187632af457411f0babc98da429aac5cae7f00424'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
