require 'buildsystems/pip'

class Py3_installer < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://installer.readthedocs.io/'
  version "1.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74eb70a9b5311cd85c7ce0408626ebf0a79e6e4feda30d27ad2c73a876dd358e',
     armv7l: '74eb70a9b5311cd85c7ce0408626ebf0a79e6e4feda30d27ad2c73a876dd358e',
       i686: 'c7a44a1b26a52f98c75a9874780053892d6b72d61e00bf30950dec942d2deda8',
     x86_64: '477f123dad03de7eee849574e426da7a82c060d461dffe21ba2b9de8616f09ee'
  })

  depends_on 'python3' => :logical

  no_source_build
end
