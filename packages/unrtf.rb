require 'buildsystems/autotools'

class Unrtf < Autotools
  description 'UnRTF is a command-line program written in C which converts documents in Rich Text Format (.rtf) to HTML, LaTeX, troff macros, and RTF itself.'
  homepage 'https://www.gnu.org/software/unrtf/'
  version '0.21.14'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.gnu.org/software/unrtf/unrtf-#{version}.tar.gz"
  source_sha256 'b1f72e87f195bd50dbc974b800918df61c881706c11716b7bd0a1981e81b9587'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '776436a265610fe95ba2fe23f1ecd026fd3e00c6838efc93b9580c071e510f65',
     armv7l: '776436a265610fe95ba2fe23f1ecd026fd3e00c6838efc93b9580c071e510f65',
       i686: 'dcd2b077269904a591b9ab436f55e60e87c6660d98a0f9b8ecfcb161a4f3a298',
     x86_64: 'b6c4d39dc9c19ceeb92f01c0bda8e40254d4f505cc04f084955244a155008d08'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  run_tests
end
