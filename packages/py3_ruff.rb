require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.12.11-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dae0fca5e13c79c8599f98213c6915c25ede889a21c17d1dc1f08443cd362ff2',
     armv7l: 'dae0fca5e13c79c8599f98213c6915c25ede889a21c17d1dc1f08443cd362ff2',
       i686: '2a8d40781978e00974b75b67a17461d9bdda5734905e7839d02b555f0e1b56dd',
     x86_64: '8abea9f06c0c019d34be39efb5d56eddab480f080f0ca62637bb215e1736b9d8'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_maturin' => :build
  depends_on 'python3' # R
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
