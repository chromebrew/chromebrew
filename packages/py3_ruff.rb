require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.11.8-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a62bd705f308cfb203318ff0dc97d2083bcbb1f32c9950458c2e3d94aa7742cb',
     armv7l: 'a62bd705f308cfb203318ff0dc97d2083bcbb1f32c9950458c2e3d94aa7742cb',
       i686: '1b472dcd33eb4b2e27a086efea97cddd6378a659616fcaa689a5a449e3b65790',
     x86_64: '10d9052912cbac6bde63fe077de3422ce7bf7baefa35e8788ec18e69537cd0aa'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
