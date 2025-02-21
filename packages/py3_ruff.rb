require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.9.7-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dca47506403811c179ba19dfdcf4d6d13d92924937cc67ffcb149535877d3a77',
     armv7l: 'dca47506403811c179ba19dfdcf4d6d13d92924937cc67ffcb149535877d3a77',
       i686: '22f3b749f63715ab1d85d747b28f826d674f76e47f895ae9fb8c22619b6546e6',
     x86_64: 'c63bfa1a63763453e59e00b84fe0477c1b73a405523aa920bb469850720fd645'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
