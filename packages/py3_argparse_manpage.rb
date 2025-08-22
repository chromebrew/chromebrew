require 'buildsystems/pip'

class Py3_argparse_manpage < Pip
  description 'Automatically build man-pages for your Python project.'
  homepage 'https://github.com/praiskup/argparse-manpage'
  version "4.7-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8e8f34339998682c0edd6c5076d25052093a752a1187aa7209ebafade52c87cb',
     armv7l: '8e8f34339998682c0edd6c5076d25052093a752a1187aa7209ebafade52c87cb',
       i686: '0b3784c7cc03928fa60cdf5bdcc6a3995f083cbc4bfa6737694f74badac54bd8',
     x86_64: 'd02312e65290338a409447fc8e9ebd02252f52a1f2f71c5445ae8eb8f65907f3'
  })

  depends_on 'python3'

  no_source_build
end
