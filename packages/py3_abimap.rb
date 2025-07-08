require 'buildsystems/pip'

class Py3_abimap < Pip
  description 'A helper for library maintainers to use symbol versioning'
  homepage 'https://github.com/ansasaki/abimap'
  version "0.4.0-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36cd69c61ae1817edeec239eab4b3c4acc2359ac252f8e74374e3ec1fc55bd25',
     armv7l: '36cd69c61ae1817edeec239eab4b3c4acc2359ac252f8e74374e3ec1fc55bd25',
       i686: '0c4d7a3092775e375e5578c0d54d1fc9255ee772a99806f73c7467df7e2470fa',
     x86_64: 'e989f3043f9d7a873a42be0bdd5071c23b8297091e2a2de0c202242ba8aa9cbc'
  })

  depends_on 'python3' => :build

  no_source_build
end
