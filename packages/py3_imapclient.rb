require 'buildsystems/pip'

class Py3_imapclient < Pip
  description 'IMAPclient is an easy-to-use, complete IMAP client library.'
  homepage 'https://imapclient.readthedocs.io/'
  version "3.0.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'baf9aec76daf998dacfeccbc4a45d88d97024de43f68a5467d0eee6b092adf91',
     armv7l: 'baf9aec76daf998dacfeccbc4a45d88d97024de43f68a5467d0eee6b092adf91',
       i686: 'af2daf9e6b076c46c2e6acbeb3f6309cdef8f81498f5b503153f7adcd4806cb6',
     x86_64: '82d0cbc5f09b75f65b870af85528609ca0148e1a7a3baeeaee6ecb89b57e0d52'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
