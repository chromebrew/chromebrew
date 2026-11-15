require 'buildsystems/pip'

class Py3_argparse_manpage < Pip
  description 'Automatically build man-pages for your Python project.'
  homepage 'https://github.com/praiskup/argparse-manpage'
  version "4.8-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '55b1639709ddf7717d2e1d89b0ae82abe424789e61ba621a6c81a778b3be87f9',
     armv7l: '55b1639709ddf7717d2e1d89b0ae82abe424789e61ba621a6c81a778b3be87f9',
       i686: 'e785c017adf23fdc8c4bcb04c183ba1b970ed6bd3c76f4c26662566faf7f129b',
     x86_64: '68359995eecb673dd8cd1ddecf860e710d52fd66bfe7c747cf4c97fc2411b3be'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
