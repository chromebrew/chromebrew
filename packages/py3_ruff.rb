require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.7.0-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '011eff8a32a4c3411f1ccff3b323b7f91c18019c4f7c443dcaa61696b954de37',
     armv7l: '011eff8a32a4c3411f1ccff3b323b7f91c18019c4f7c443dcaa61696b954de37',
       i686: '2f6f0a08c29b0195403be73c53d61fc8a5a0ed9c1d225c5f8193bf1323ea8e7c',
     x86_64: '69718b41767d0169fe8dff04398b3d4b9e7bb4309359546647682d06e8c9883c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
