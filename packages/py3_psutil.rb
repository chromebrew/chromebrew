require 'buildsystems/pip'

class Py3_psutil < Pip
  description 'psutil is a cross-platform library for process and system monitoring in Python.'
  homepage 'https://github.com/giampaolo/psutil/'
  version "7.2.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '888d9f34fbf8b3cfead305f979b754942d45987ca17ed96a716ae0fc39f3b93e',
     armv7l: '888d9f34fbf8b3cfead305f979b754942d45987ca17ed96a716ae0fc39f3b93e',
       i686: 'd2a22e62f9b3408f7a01feea9061ca5339aadd5d20994af41ff3399d8e32de7b',
     x86_64: '7787fe39f8046b2a049c484888107499656f678a64e0f6f82c8cc8bd0f552dec'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
