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
    aarch64: '4db7218ca1d71e65c87d825402c4aaac738477bb4eeab50a6dd20dae0d449c48',
     armv7l: '4db7218ca1d71e65c87d825402c4aaac738477bb4eeab50a6dd20dae0d449c48',
       i686: '76cd776fa7a13440362872ca45f9c3feeaeba43ed0a84904d122df19ff45095b',
     x86_64: 'd9542be2cdbbc5f82391db9c983236fffc5562557803aa7f2f3937df4f915d91'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  run_tests
end
