require 'buildsystems/pip'

class Py3_imapclient < Pip
  description 'IMAPclient is an easy-to-use, complete IMAP client library.'
  homepage 'https://imapclient.readthedocs.io/'
  version "4.3.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a28788c45052269c1ac6916b1cd2034c78bc8e539f6b2a3353bf49c46695454',
     armv7l: '6a28788c45052269c1ac6916b1cd2034c78bc8e539f6b2a3353bf49c46695454',
       i686: '5f141cf06970356d916629af34c89fa0cf5987ec735d991fde036ad925a5a630',
     x86_64: '4997bb86e6f14d7e6e9d3146b3f5bb11c7007b80e5decd26dc371fe7e8b5d1cd'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
