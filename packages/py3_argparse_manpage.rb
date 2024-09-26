require 'buildsystems/pip'

class Py3_argparse_manpage < Pip
  description 'Automatically build man-pages for your Python project.'
  homepage 'https://github.com/praiskup/argparse-manpage'
  version "4.6-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4772d03dbf2b21ddc721ce5da05ee13a730aa1d92221607489dd1d5497125a73',
     armv7l: '4772d03dbf2b21ddc721ce5da05ee13a730aa1d92221607489dd1d5497125a73',
       i686: '1352bf5790364f80d5d89dc217c4e96935a5ae1e9b858d01ab1d4d303a2b2335',
     x86_64: '9aded4463afea06b23c6db412005f8c650e4edf2a24038b5e2f6ae08d0bf276f'
  })

  depends_on 'python3'

  no_source_build
end
