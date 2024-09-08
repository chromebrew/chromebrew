require 'buildsystems/pip'

class Py3_argparse_manpage < Pip
  description 'Automatically build man-pages for your Python project.'
  homepage 'https://github.com/praiskup/argparse-manpage'
  version '4.6-py3.12'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7a76a57baa1b69c2a4ff85bb1e4e3ef59b0d5d08aa87ddc074bc8498365adf1',
     armv7l: 'a7a76a57baa1b69c2a4ff85bb1e4e3ef59b0d5d08aa87ddc074bc8498365adf1',
       i686: '38e973794b405f3de45d51cbd35650bd087ac38d663e67ddeb43e09fc092c7f8',
     x86_64: 'bdb3fa284f9cdd9323dbd07b1403c8c1543cc66bbb81f9da8b1d2a2ff7fb38d5'
  })

  depends_on 'python3'
end
