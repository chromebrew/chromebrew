require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.10.0-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '90baf9d04520b8c9a4986f7a7949ae9ee5edcec36f0acc2b8726b0563e3535c8',
     armv7l: '90baf9d04520b8c9a4986f7a7949ae9ee5edcec36f0acc2b8726b0563e3535c8',
       i686: 'fd340660ec3f5acf35c6ba41475894656917cab7ed8b2b4fe3f4724b5fd48202',
     x86_64: '5b2c9aaaa0271f8e9010048f2d431144c1e142f050b06ebfe0dac87231159159'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
