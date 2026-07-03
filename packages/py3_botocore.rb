require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.40-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4421d441d57d989d506c9f58eb40a4adc9bb4f75efd9c64edcb8a38bc8438d75',
     armv7l: '4421d441d57d989d506c9f58eb40a4adc9bb4f75efd9c64edcb8a38bc8438d75',
       i686: 'db465b0cce0c3316e8922c6c1cac4aca300d1592fac6f22c9430cb967b0ddefb',
     x86_64: '3f83e8d77a63c94672d8aa576f52149b67912d7da29a40b4a0f12aadcd2ded2c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
