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
    aarch64: '62f61a9cc6caf14d41f14cfe0183735c4b4ca8b2603c59d5a05d484a5660fdac',
     armv7l: '62f61a9cc6caf14d41f14cfe0183735c4b4ca8b2603c59d5a05d484a5660fdac',
       i686: 'b5189ed4e576115ffd2f26a8f5f6db647619f64a0c8873772588e6d4279358f2',
     x86_64: '473639517432121b3f000bf0724009155de2abbf19b0c2d5b46a75ab23ea55b9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
