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
       i686: '9796cf0ab3bb78751fcff1cd5e7c96b0663e17ef3b6a130bab85e743cee6a745',
     x86_64: '56666656041c014102e4d874154f85da592135c9dba833df05b70f80748add24'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
