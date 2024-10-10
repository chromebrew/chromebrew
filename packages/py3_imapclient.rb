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
    aarch64: '247931914458ab4f88148f919be4481dfbedf22be731b8366bffa40551c4ace4',
     armv7l: '247931914458ab4f88148f919be4481dfbedf22be731b8366bffa40551c4ace4',
       i686: '5c8f0fd0b96129dfea0b3a760cc93a79ee581d4e40abea179089083ca40a9cc0',
     x86_64: 'c150f8dbd5d4c50c4ac8067b46b491aa2ba344de29c92b0f7820ee45199e4b7a'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
