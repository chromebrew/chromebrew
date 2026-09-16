require 'buildsystems/pip'

class Py3_streamlit < Pip
  description 'A faster way to build and share data apps'
  homepage 'https://streamlit.io/'
  version "1.64.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '01b9c29b2bce2eb1d196e306ed17af2fa21c4838fb5ef17613c4b3087016bbc2',
     armv7l: '01b9c29b2bce2eb1d196e306ed17af2fa21c4838fb5ef17613c4b3087016bbc2',
       i686: '4c58946760a600d048293645f0233cb09b264a30d7a789217091c2e0e657bdf4',
     x86_64: '8fba70b31af691b7f3758f4345ce65636ac817c8d8da52762c2ceee2d73498af'
  })

  depends_on 'python3' => :logical

  no_source_build
end
