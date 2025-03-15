require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.11.0-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6dd3c2c67f943294aec34e03d6b8983bf3188ed66ac596e0622afc14b122c372',
     armv7l: '6dd3c2c67f943294aec34e03d6b8983bf3188ed66ac596e0622afc14b122c372',
       i686: 'e8dcaebc60ed64c0227dea0a4efa0a0a1233ae93dcdeb5d10d76cde50aba30de',
     x86_64: '5fa1e4e4ba4ac92f691045043f01b8ba255e72e014f6e20e2d412277c6875845'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
