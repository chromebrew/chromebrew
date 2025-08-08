require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.12.8-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a979885bb48e4d2ed0ec77e6a4a8873d468e6026a1e3a8c34b21f11e16b41fb0',
     armv7l: 'a979885bb48e4d2ed0ec77e6a4a8873d468e6026a1e3a8c34b21f11e16b41fb0',
       i686: '880f39c5f3cc46e59d765c9d86c34cb682f5f3cbb40cadf11f1561fe189124c7',
     x86_64: '6dc857af16cd08420eb34d51ac3017089e7d1c8ab2d9e37fe9261175b2a3f5b9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_maturin' => :build
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
