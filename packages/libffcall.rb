require 'buildsystems/autotools'

class Libffcall < Autotools
  description 'GNU libffcall is a library which can be used to build foreign function call interfaces in embedded interpreters.'
  homepage 'https://www.gnu.org/software/libffcall/'
  version '2.5'
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/libffcall/libffcall-#{version}.tar.gz"
  source_sha256 '7f422096b40498b1389093955825f141bb67ed6014249d884009463dc7846879'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '30ebb220d932b87a34428d3fa6dae866ac5dc417007d223ec7d87cab96b706bf',
     armv7l: '30ebb220d932b87a34428d3fa6dae866ac5dc417007d223ec7d87cab96b706bf',
       i686: 'a48db57667d8867fa0566372c4177711fd6532199b416ac6874e4a82d1310ad0',
     x86_64: '6f0395b9c855cc827bdc35ca351a4dc8367c42a601972b6b6986f7d8cd6277a5'
  })

  depends_on 'glibc' # R
end
