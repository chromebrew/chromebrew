require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.13.0-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd715c8eb5960361c8f71a5d001857bf86c5372501bb2fac7e3463851e82d09bd',
     armv7l: 'd715c8eb5960361c8f71a5d001857bf86c5372501bb2fac7e3463851e82d09bd',
       i686: '25d93281c4efdaf92848fa50d5dbf8fe0b7ee9e7a1b8a90f04726af340fcc32d',
     x86_64: '2d0359b6a556ffbdf547069c128f23d7ad05ad44609c83ba4d29242de42e0c9c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_maturin' => :build
  depends_on 'python3' # R
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
