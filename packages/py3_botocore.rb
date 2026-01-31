require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.39-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1b75581e43fa2b5ef35a8df994ad8ba25e47b993bc44ccce071353a1f65b6473',
     armv7l: '1b75581e43fa2b5ef35a8df994ad8ba25e47b993bc44ccce071353a1f65b6473',
       i686: '3c7f6c67b85adf1f6cd80ac3336e5d7b00a7680c5a83c1c15299e909ee2f9501',
     x86_64: '2f9b67bb87abc6db7570bd26180a45cc7e179c068a1181beaa5e8cbda43bc9c6'
  })

  depends_on 'python3' => :build

  no_source_build
end
