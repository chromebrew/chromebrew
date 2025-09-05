require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.12.12-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e43a0f5b11da9f6ec7613dcb945d357e22b7ff42fa0d6835afa01114d84c42a3',
     armv7l: 'e43a0f5b11da9f6ec7613dcb945d357e22b7ff42fa0d6835afa01114d84c42a3',
       i686: 'b44e2b2180eae3a5183634cf861cceced4d6aaae4f6820872420443eca4ddb69',
     x86_64: '618532412263a2f9467a0f090949e9262b00c23fdd93e795eb336b6dda3cd579'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_maturin' => :build
  depends_on 'python3' # R
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
