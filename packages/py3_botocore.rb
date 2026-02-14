require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.49-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f8bcf96c22ff0255927f13a487fed2c5048c661d8633c68227441617ed5feeea',
     armv7l: 'f8bcf96c22ff0255927f13a487fed2c5048c661d8633c68227441617ed5feeea',
       i686: '90491c164ed58e173660e4fb26bdc649360549f33959a2f43be4df5c02ab27e0',
     x86_64: '548993c4ae67df10ad77c637377687659acf9d7555665166b77c348e33e5c8a0'
  })

  depends_on 'python3' => :build

  no_source_build
end
