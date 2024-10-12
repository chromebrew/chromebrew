require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.6.9-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0d1b20f9166f942c0a526d3389b518cbf363308da28bf90d9b32045d6b2b1f6c',
     armv7l: '0d1b20f9166f942c0a526d3389b518cbf363308da28bf90d9b32045d6b2b1f6c',
       i686: '113d177fd1f7e6c6b747697040716c08371604a10bc0cd129d767e92592ee8db',
     x86_64: 'a1aefe717c6744461804ad99dc68f77135d9821d84cb348de39352ecea43d33a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
