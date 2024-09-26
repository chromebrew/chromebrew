require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.6.7-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '377dc59b2d3cf938b0fee86be1b11ee207cd15e7da981422ada3fad18dc18363',
     armv7l: '377dc59b2d3cf938b0fee86be1b11ee207cd15e7da981422ada3fad18dc18363',
       i686: '2479c27d1097151efc828318f10ca1c5bdc40a54750dc933814d42f09c92b375',
     x86_64: '080dac5fe3ee1d422bb8124fc115571c039a094fb273f7eef21857d267e9d139'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
