require 'buildsystems/pip'

class Py3_zipp < Pip
  description 'Zipp is a backport of pathlib-compatible object wrapper for zip files.'
  homepage 'https://github.com/jaraco/zipp/'
  version "3.23.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '931813065312c27a98600c7d4c0177b12b43e1ba9128b8545e4b103a6c76ddf8',
     armv7l: '931813065312c27a98600c7d4c0177b12b43e1ba9128b8545e4b103a6c76ddf8',
       i686: 'e2d511b99e62a0785f300b480d9d748ea00a11c19b42194342dde5df1116f63b',
     x86_64: '5da9036ce8287ee89f05039f504039669eed68dafea685f15f8155bc0a019d04'
  })

  depends_on 'python3' => :build

  no_source_build
end
