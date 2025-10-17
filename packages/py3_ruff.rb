require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.14.1-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '964e58d154021123d74a8326cb2f0c397255822b458a2e164c9ff00e2a8c8000',
     armv7l: '964e58d154021123d74a8326cb2f0c397255822b458a2e164c9ff00e2a8c8000',
       i686: '4c25344726b93572937cfa7f95c07f54b8b2230570de4b935e5e96727edb667b',
     x86_64: '052b1e5b51c6fcb71f5cda3439eb500ec8cfbe0bbe3db40aaa0c41002ff170a2'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_maturin' => :build
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
