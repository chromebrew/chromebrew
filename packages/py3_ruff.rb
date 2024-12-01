require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.8.1-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '270f11f1fbe42952cfd7c6112284f2cdbf3f08be9c35e305185a33f9d3dcd3a5',
     armv7l: '270f11f1fbe42952cfd7c6112284f2cdbf3f08be9c35e305185a33f9d3dcd3a5',
       i686: 'c069bec3751bdc9169b66ed03a625f3fa54342ebbf8afd325e92e973ab30ad34',
     x86_64: '4283ae832d5802a08a040103ed24236aee9ef37069879ce7338ae8c561dc65d6'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
