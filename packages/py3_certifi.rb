require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2026.7.22-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b8c85bde9c8c769b38e8f89831672477879d78cb657560199dd2b6fbfb71c75',
     armv7l: '3b8c85bde9c8c769b38e8f89831672477879d78cb657560199dd2b6fbfb71c75',
       i686: 'b556188ea9a6bba694b184be7f9c55a00eeca09ca07983282b9880ada67e644e',
     x86_64: '1aff09a4c714e826dd9840a015c92ca3a6b89ebbd5e9c280de2653a425b31c68'
  })

  depends_on 'python3' => :logical

  no_source_build
end
