require 'buildsystems/pip'

class Py3_imapclient < Pip
  description 'IMAPclient is an easy-to-use, complete IMAP client library.'
  homepage 'https://imapclient.readthedocs.io/'
  version "4.1.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b8a63a570c1e3d8f8204d97906ef53797d6ac61df9fa5d49ac06c322d214025f',
     armv7l: 'b8a63a570c1e3d8f8204d97906ef53797d6ac61df9fa5d49ac06c322d214025f',
       i686: '89fa694da64dcb4f1db1a19c6ed42c506482354b631ab06809fca6ee34381b38',
     x86_64: '12a001c6e2e04bd99bce9565f30180ccefd32af1b94474c38514582e49ecae58'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
