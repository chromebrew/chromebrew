require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2026.6.17-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea354d3ca5d71ce9c4b4fcfd20f0c7039b03a5f4c9842abdac6073e1699fda4d',
     armv7l: 'ea354d3ca5d71ce9c4b4fcfd20f0c7039b03a5f4c9842abdac6073e1699fda4d',
       i686: 'dce0a98a419d7ccd027dceb29d6f0760930d70728f770e9a2453e60e853a0bbd',
     x86_64: '65d956b435080c8c7745b750a690812cd31a79df318775f0ad7ea1f3d4daa08b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
