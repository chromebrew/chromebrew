require 'buildsystems/pip'

class Py3_argcomplete < Pip
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  version "3.7.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95f8e735d79990b39c5d370665fff20ffe720e63495850faf3fa471f9c5a5e33',
     armv7l: '95f8e735d79990b39c5d370665fff20ffe720e63495850faf3fa471f9c5a5e33',
       i686: '344d22bdbb84668942daad75295343daca64999c1179c01639927a02e1e857a7',
     x86_64: '01d308614b9089e3c7e6b044a12a8de7e763614632c07bd838ea50298a684f9f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
