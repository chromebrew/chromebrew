require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.9.9-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1dcc79f1293d1e7cb82e3d235420068e20427d6bab04d65f6818cecb9ab1a5e7',
     armv7l: '1dcc79f1293d1e7cb82e3d235420068e20427d6bab04d65f6818cecb9ab1a5e7',
       i686: 'b5189ed4e576115ffd2f26a8f5f6db647619f64a0c8873772588e6d4279358f2',
     x86_64: '652ffe546d47e1782eb6915e6c37e1f417f273da3719dd8efb89a7eee947be85'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
