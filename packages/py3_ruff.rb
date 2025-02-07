require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.9.5-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8c433bbd0010444301f8997549e2a08ee063ee7a92fe4843af4b55dcc6ec7672',
     armv7l: '8c433bbd0010444301f8997549e2a08ee063ee7a92fe4843af4b55dcc6ec7672',
       i686: '46ed8f86481fb811a20dd0655e24f6704a66a06c087a612bc753e04be711df8e',
     x86_64: 'dcce614658a4df8aa7396a1cbf0132f4e164669b257920de5ffa36743ec0a864'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
