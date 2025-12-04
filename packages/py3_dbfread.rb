require 'buildsystems/pip'

class Py3_dbfread < Pip
  description 'DBFread reads DBF Files with Python.'
  homepage 'https://dbfread.readthedocs.io/'
  version "2.0.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ecb498259419a00e0897bfaf51efb1fb174a5033aa5866c7a9a4f76178d4b05c',
     armv7l: 'ecb498259419a00e0897bfaf51efb1fb174a5033aa5866c7a9a4f76178d4b05c',
       i686: 'fae64282d8719809b5c2c988e3a84d8f6a3df2281d68de5941db13e3710d9309',
     x86_64: 'd54736d4025b2e4510891369280a96f0b9aec22beb12560ff4acdbee11d78426'
  })

  depends_on 'python3' => :build

  no_source_build
end
