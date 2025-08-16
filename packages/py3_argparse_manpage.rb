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
    aarch64: '97aaef0f4560f7381c6018ad9e2d11e9f26c827182ec79b9e14fdb3464630599',
     armv7l: '97aaef0f4560f7381c6018ad9e2d11e9f26c827182ec79b9e14fdb3464630599',
       i686: 'fcfcdb4032c30f8c05ee17a6674a3583f6027164a1f111e350ec64151beea69c',
     x86_64: '6c34361a32e4bf09e57752ed25d069ac3af34098140c40dddb29d24700c15fc9'
  })

  depends_on 'python3'

  no_source_build
end
