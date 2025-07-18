require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.12.4-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2f948928627b1364f1401e7497c8c04d4a5f695fee382f6ce2ea26bb0c707530',
     armv7l: '2f948928627b1364f1401e7497c8c04d4a5f695fee382f6ce2ea26bb0c707530',
       i686: 'f88093474cebd86c143d52a5773839ec2ae1fa906468b091edbc5c97333c4cf8',
     x86_64: '257e913316fd1e5a39c2b61d8604637d4f7d2500d12461f2e4a8fe1a7a41c25b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build

  no_source_build
end
