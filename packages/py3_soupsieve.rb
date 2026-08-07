require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "2.9.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9a2f50b5a8075f0fe87eab8876e8e4630d5835ddb1081b7b5e822b7bd722c796',
     armv7l: '9a2f50b5a8075f0fe87eab8876e8e4630d5835ddb1081b7b5e822b7bd722c796',
       i686: 'dcae98afd49287f6ff6edd4812900b947c6ad035d15efff51e59a8a251950189',
     x86_64: 'baf8326fe8fca013fff9a6eeb268895c74bb5e7aa2af71d5a430765c17aa1d11'
  })

  depends_on 'python3' => :logical

  no_source_build
end
