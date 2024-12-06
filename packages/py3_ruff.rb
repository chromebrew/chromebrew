require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.8.2-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '034fab5b0b92ca74b647c981cc148266f4a02a9732b5be7e9960ee3811bbc17f',
     armv7l: '034fab5b0b92ca74b647c981cc148266f4a02a9732b5be7e9960ee3811bbc17f',
       i686: '4897f5359c3f2172140a61d91f1dec57061be1e59a937294649d0ef7a9c1a5ea',
     x86_64: '36b05886350c2fdaf4044526416b8a54a2a74fd9d70a67ddaa32e03e295a048e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
