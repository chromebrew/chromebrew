require 'buildsystems/pip'

class Py3_dbfread < Pip
  description 'DBFread reads DBF Files with Python.'
  homepage 'https://dbfread.readthedocs.io/'
  version '2.0.7-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '93cfff2250b28c5ebabbcb9f95197f2869e1769aa9e385a810a57c71a9945f55',
     armv7l: '93cfff2250b28c5ebabbcb9f95197f2869e1769aa9e385a810a57c71a9945f55',
       i686: 'bf5940ad975c45a48914ac09ba0677317555154bc153fda751ccce569c135ee8',
     x86_64: '1a9ae024122fdc0df2e2973ff78e9ddc7c78d0cea43c9e29ffe48732ef5a5bb7'
  })

  depends_on 'python3' => :build
end
