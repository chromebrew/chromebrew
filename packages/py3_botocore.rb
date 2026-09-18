require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.97-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '58b9be2a59f03783f827ce10bd5d0d1a9b0a28863b373134cbbe8371a74c745b',
     armv7l: '58b9be2a59f03783f827ce10bd5d0d1a9b0a28863b373134cbbe8371a74c745b',
       i686: '3c433041ce9f6f6ae94309ec10055e381bc1ed32aec55cc32cfd841ff113d49d',
     x86_64: '6b8ab91332d27c4d6450344decd453723ef1fc7075d81f32b539d82cbade93f5'
  })

  depends_on 'python3' => :logical

  no_source_build
end
