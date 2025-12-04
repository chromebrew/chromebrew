require 'buildsystems/pip'

class Py3_dicttoxml < Pip
  description 'DicttoXML converts Python dictionaries into XML strings.'
  homepage 'https://github.com/quandyfactory/dicttoxml/'
  version "1.7.16-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b29787cecd0957bed357e169a0d7e0f15d6a9a7a26006abf21b44641e1818cc',
     armv7l: '9b29787cecd0957bed357e169a0d7e0f15d6a9a7a26006abf21b44641e1818cc',
       i686: 'b7654dfef7221267c679d74cbe77aec260ecc3d0e21121a8f1b264a6448331e4',
     x86_64: '45b7f57011dd2b74cd8a95c9f2d77fc769703b7f10f2b2b3eaabecf9a34bcf45'
  })

  depends_on 'python3' => :build

  no_source_build
end
