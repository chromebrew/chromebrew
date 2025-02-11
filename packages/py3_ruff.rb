require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.9.6-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c04dfa232e992cf7e99c7fc07d80e261f76852f56826468b901c39da1bd30827',
     armv7l: 'c04dfa232e992cf7e99c7fc07d80e261f76852f56826468b901c39da1bd30827',
       i686: '25d4b4c14a1f07d1af4b06afbcc6e5ead02f6eb63bf25f25cd8cd839bdeba7bc',
     x86_64: '76c309f7d3e3548e20a3db5beb5db8f8c47e2f29035723af583318a5d7f0c882'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
