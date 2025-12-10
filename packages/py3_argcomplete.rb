require 'buildsystems/pip'

class Py3_argcomplete < Pip
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  version "3.6.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea66102388d11852da58f6860ac74054874673d911a8235d2412d352e7de4a42',
     armv7l: 'ea66102388d11852da58f6860ac74054874673d911a8235d2412d352e7de4a42',
       i686: '908f6fbe9ae437b6f0fc96a08bdf0f562f30ff51391e6fb6f958eec8f47f4164',
     x86_64: '26926e3476cf98219b720588b109c871c0345918cac5539fb04263ba99239b30'
  })

  depends_on 'python3' => :build

  no_source_build
end
