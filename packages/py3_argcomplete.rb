require 'buildsystems/pip'

class Py3_argcomplete < Pip
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  version "3.7.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9273041206eda3a8c11b66c0e4175a79d67e9d43660fd38ab7a3b37473fb49b0',
     armv7l: '9273041206eda3a8c11b66c0e4175a79d67e9d43660fd38ab7a3b37473fb49b0',
       i686: '13031479d7e6483b2d256be257299b97862e0f2930b022e7f2ee3a91f3b4db8d',
     x86_64: '75d953cfacd873457901063b4d0355d3ceb99e000bdf6fab7b963ee5ad2e6327'
  })

  depends_on 'python3' => :logical

  no_source_build
end
