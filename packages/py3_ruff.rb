require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.7.2-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56771f60a4b0b2ef4419c0de50736dab74df53ad20ddf8569009e223b4e27fbf',
     armv7l: '56771f60a4b0b2ef4419c0de50736dab74df53ad20ddf8569009e223b4e27fbf',
       i686: '03104e0cc1212c22f6f81f822ed48e950f1de537df2ccac619eb5fb1686d84a5',
     x86_64: '30daebc2ab07c1ca89a9a5aba5dfdd6bd140e0e832673c45c72800e68c5d0ee7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
